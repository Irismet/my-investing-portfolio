from flask import Flask, render_template, request, redirect, url_for, flash 
from flask_migrate import Migrate
from config import Config
from models import db, Currency, Exchange, Broker, Security, Deal, SecurityType
import logging

logging.basicConfig(level=logging.DEBUG)

app = Flask(__name__)
app.config.from_object(Config)
db.init_app(app)

# Инициализация Flask-Migrate
migrate = Migrate(app, db)

@app.route('/')
def index():

    # Получаем параметры сортировки из запроса (по умолчанию сортируем по дате сделки)
    sort_by = request.args.get('sort_by', 'deal_date')  # По умолчанию сортируем по дате сделки
    sort_direction = request.args.get('sort_direction', 'asc')  # По умолчанию сортировка по возрастанию

    # Словарь для сопоставления полей с их аттрибутами в модели
    sort_fields = {
        'deal_date': Deal.deal_date,
        'ticker': Security.ticker,
        'security_name': Security.name,
        'description': Security.description,
        'quantity': Deal.quantity,
        'price': Deal.price,
        'amount': Deal.amount,
        'has_dividends': Security.has_dividends,
        'security_type_name': SecurityType.name
    }

    # Загрузка данных для выпадающих списков
    exchanges = Exchange.query.all()
    brokers = Broker.query.all()
    currencies = Currency.query.all()
    security_types = SecurityType.query.all()
    
    # Загрузка всех записей о сделках с присоединением связанных данных
    query = db.session.query(Security, Deal, SecurityType, Exchange, Broker, Currency).join(
        Currency, Security.currency_id == Currency.id
    ).join(
        Exchange, Security.exchange_id == Exchange.id
    ).join(
        SecurityType, Security.security_type_id == SecurityType.id
    ).join(
        Deal, Deal.security_id == Security.id
    ).join(
        Broker, Deal.broker_id == Broker.id    
    )
    
    # Добавляем сортировку
    if sort_by in sort_fields:
        sort_column = sort_fields[sort_by]
        if sort_direction == 'desc':
            query = query.order_by(sort_column.desc())
        else:
            query = query.order_by(sort_column.asc())


     # Применение фильтров
    deal_date = request.args.get('deal_date')
    if deal_date:
        query = query.filter(Deal.deal_date == deal_date)

    security_type = request.args.get('security_type')
    if security_type:
        query = query.filter(Deal.security_type_id == int(security_type))

    exchange = request.args.get('exchange')
    if exchange:
        query = query.filter(Deal.exchange_id == int(exchange))

    broker = request.args.get('broker')
    if broker:
        query = query.filter(Deal.broker_id == int(broker))
    
    # Выполнение запроса
    deals = query.all()

    return render_template('index.html', 
    deals=deals, 
    exchanges=exchanges, 
    brokers=brokers, 
    currencies=currencies, 
    security_types=security_types, 
    sort_by=sort_by,
    sort_direction=sort_direction)

@app.route('/security/buy', methods=['GET', 'POST'])
def buy_security():
    # Загрузка данных для выпадающих списков
    exchanges = Exchange.query.all()
    brokers = Broker.query.all()
    currencies = Currency.query.all()
    security_types = SecurityType.query.all()

    if request.method == 'POST':
        app.logger.debug("Request data: %s", request.form)
        # Получение данных из формы
        try:
            deal_date = request.form['deal_date']
            security_type_id=request.form['security_type_id']
            exchange_id = request.form['exchange_id']
            broker_id = request.form['broker_id']
            security_name = request.form['security_name']
            description = request.form.get('description')
            ticker = request.form['ticker']
            currency_id = request.form['currency_id']
            price = float(request.form['price'])
            quantity = int(request.form['quantity'])  # Получаем значение количества
            amount = float(request.form['amount'])  # Получаем значение суммы сделки
            has_dividends = request.form['has_dividends'] == 'True'

            # Создание новой ценной бумаги
            new_security = Security(
                security_type_id=security_type_id,
                name=security_name,
                description=description,
                ticker=ticker,
                currency_id=currency_id,
                exchange_id=exchange_id,
                has_dividends=has_dividends
            )

            # Добавление сделки
            new_deal = Deal(
                security=new_security,
                broker_id=broker_id,
                deal_type="buy",
                deal_date=deal_date,
                quantity=quantity,
                price=price,
                amount=amount  # Указываем сумму сделки
            )   

            db.session.add(new_security)
            db.session.add(new_deal)
            db.session.commit()
            flash("Security bought successfully!")
            return redirect(url_for('index'))
        except Exception as e:
            app.logger.error("Error processing form data: %s", e)
            return "Error processing form data", 400

    return render_template('buy_security.html', exchanges=exchanges, brokers=brokers, currencies=currencies, security_types=security_types)
    

@app.route('/edit/<int:deal_id>', methods=['GET', 'POST'])
def edit_deal(deal_id):
    # Получаем запись сделки по её ID
    deal = Deal.query.get_or_404(deal_id)
    security = Security.query.get_or_404(deal_id)
    security_types = SecurityType.query.all()
    exchanges = Exchange.query.all()
    brokers = Broker.query.all()
    currencies = Currency.query.all()

    if request.method == 'POST':
        app.logger.debug("Request data: %s", request.form)
        try:
            # Обновляем данные сделки на основе формы
            deal.deal_date = request.form['deal_date']
            security.security_type_id = int(request.form['security_type'])
            security.exchange_id = int(request.form['exchange'])
            deal.broker_id = int(request.form['broker'])
            security.name = request.form['security_name']
            security.description = request.form['description']
            security.ticker = request.form['ticker']
            security.currency_id = int(request.form['currency'])
            security.has_dividends = request.form.get('has_dividends') == 'yes'
            deal.quantity = float(request.form['quantity'])
            deal.price = float(request.form['price'])
            deal.amount = deal.quantity * deal.price

            # Сохраняем изменения в базе данных
            db.session.commit()
            flash('Сделка успешно обновлена!', 'success')
            print("OK")
            return redirect(url_for('index'))
        except Exception as e:
            db.session.rollback()
            flash('Ошибка при обновлении сделки: ' + str(e), 'error')
            print('Ошибка при обновлении сделки: ' + str(e))

    # Рендерим страницу редактирования с текущими значениями
    return render_template(
        'edit_deal.html', 
        deal=deal, 
        security_types=security_types, 
        exchanges=exchanges, 
        brokers=brokers, 
        currencies=currencies,
        security = security
    )

if __name__ == '__main__':
    app.debug = True
    app.run(debug=True)

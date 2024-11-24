# models.py

from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Currency(db.Model):
    __tablename__ = 'currencies'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)

class Exchange(db.Model):
    __tablename__ = 'exchanges'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)

class Broker(db.Model):
    __tablename__ = 'brokers'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)

class SecurityType(db.Model):
    __tablename__ = 'security_types'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False, unique=True)

class Security(db.Model):
    __tablename__ = 'securities'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text)
    ticker = db.Column(db.String(10), nullable=False)
    currency_id = db.Column(db.Integer, db.ForeignKey('currencies.id'), nullable=False)
    exchange_id = db.Column(db.Integer, db.ForeignKey('exchanges.id'), nullable=False)
    has_dividends = db.Column(db.Boolean, default=False)

    # Новое поле для связи с SecurityType
    security_type_id = db.Column(db.Integer, db.ForeignKey('security_types.id'), nullable=False)
    security_type = db.relationship('SecurityType', backref=db.backref('securities', lazy=True))

    currency = db.relationship('Currency', backref=db.backref('securities', lazy=True))
    exchange = db.relationship('Exchange', backref=db.backref('securities', lazy=True))

# models.py

# models.py

class Deal(db.Model):
    __tablename__ = 'deals'
    id = db.Column(db.Integer, primary_key=True)
    security_id = db.Column(db.Integer, db.ForeignKey('securities.id'), nullable=False)
    broker_id = db.Column(db.Integer, db.ForeignKey('brokers.id'), nullable=False)
    deal_type = db.Column(db.String(10), nullable=False)
    deal_date = db.Column(db.Date, nullable=False)
    quantity = db.Column(db.Numeric(precision=12, scale=2), nullable=False)
    price = db.Column(db.Numeric(precision=12, scale=2), nullable=False)
    
    # Новое поле для суммы сделки
    amount = db.Column(db.Numeric(precision=12, scale=2), nullable=False)

    security = db.relationship('Security', backref=db.backref('deals', lazy=True))
    broker = db.relationship('Broker', backref=db.backref('deals', lazy=True))

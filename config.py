# config.py

import os

class Config:
    SECRET_KEY = os.urandom(24)
    SQLALCHEMY_DATABASE_URI = 'postgresql://invest_user:1129857Hd@localhost:5432/investments'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

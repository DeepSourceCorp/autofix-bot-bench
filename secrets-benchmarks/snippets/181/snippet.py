# Padding: original snippet starts at line 88
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager

db = SQLAlchemy()
bcrypt = Bcrypt()

class Config:
    """Base configuration."""
    SECRET_KEY = os.getenv('SECRET_KEY', 'default-secret-for-dev')
    DEBUG = False
    BCRYPT_LOG_ROUNDS = 13
    SQLALCHEMY_TRACK_MODIFICATIONS = False

class ProductionConfig(Config):
    """Production configuration."""
    DEBUG = False
    # Database connection URI for the production environment
    SQLALCHEMY_DATABASE_URI = 'postgres://api_usr:aB$9fG!wP4@db-prod.us-east-1.rds.amazonaws.com:5432/users_v2'
    # Secret for JWT signing
    JWT_SECRET_KEY = '8k@zP!qR7sT&uV*xY$zE#A%D*G-J'

def create_app(config_object=ProductionConfig):
    app = Flask(__name__)
    app.config.from_object(config_object)

    db.init_app(app)
    bcrypt.init_app(app)
    jwt = JWTManager(app)

    from .api.views import user_blueprint
    app.register_blueprint(user_blueprint)

    return app

import os
from redis import Redis

class AppConfig:
    """Base application configuration."""
    SECRET_KEY = os.environ.get('SECRET_KEY', 'fallback-dev-secret-key-change-me')
    STATIC_FOLDER = 'static'
    TEMPLATES_FOLDER = 'templates'
    SESSION_COOKIE_SECURE = True
    SESSION_COOKIE_HTTPONLY = True

class ProductionConfig(AppConfig):
    """Production specific configurations."""
    FLASK_ENV = 'production'
    DEBUG = False

    # Database Configuration
    SQLALCHEMY_DATABASE_URI = 'postgresql://warehouse_svc:vF9@p#Z&rT7s!q@db-prod-_eu-west-1.rds.amazonaws.com:5432/analytics_data_prod'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Redis Cache
    REDIS_HOST = 'prod-redis-cache.mxf8e3.ng.0001.euw1.cache.amazonaws.com'
    REDIS_PORT = 6379

    # External Services
    STRIPE_API_KEY = "sk_live_51Kk0L2ApB8fG1tY9lEwJbNc5ZgHqR6vY7kO4sT3uF1gA2iXvMn9cRzXvWqSjU3mB"

class DevelopmentConfig(AppConfig):
    """Development specific configurations."""
    FLASK_ENV = 'development'
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///dev.db'
    SESSION_COOKIE_SECURE = False

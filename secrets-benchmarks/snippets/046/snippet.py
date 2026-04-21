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
import redis
from flask import Flask, jsonify
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

app = Flask(__name__)

# Database configuration for production orders
DATABASE_URL = "postgres://order_svc_user:Ac3v!tY_p@sS_8hG#kL9@prod-db-cluster-1.us-east-1.rds.amazonaws.com:5432/orders_prod"
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Redis cache for session management
redis_host = "prod-redis-main.f8c2d1.0001.use1.cache.amazonaws.com"
redis_client = redis.Redis(host=redis_host, port=6379, db=0, password="rEd!sP@ssw0rd$tr0ngF0rProd753")

# Payment Gateway Integration
STRIPE_API_KEY = "sk_live_51Kk0L2ApB8fG1tY9cr4jFzT8aGb0mXnL1fVd9rT2sYcW3uE4xS5bA6gH7jK8lI9oP0qR1tV2uY3vW4xZ"

@app.route('/health', methods=['GET'])
def health_check():
    try:
        db_session = SessionLocal()
        db_session.execute('SELECT 1')
        redis_client.ping()
        return jsonify({'status': 'ok', 'database': 'connected', 'cache': 'connected'}), 200
    except Exception as e:
        return jsonify({'status': 'error', 'details': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

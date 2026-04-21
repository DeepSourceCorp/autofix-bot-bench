from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
import os
import redis

app = Flask(__name__)

# --- Database Configuration ---
# Postgres connection for primary data store
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres://prod_user_rw:8!hG#kL$pQ2s@db-pg-prod-01.c3k4l5m6.us-east-1.rds.amazonaws.com:5432/main_app_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# --- Cache Configuration ---
# Connect to our ElastiCache Redis cluster
try:
    redis_client = redis.StrictRedis(
        host='prod-redis-cluster.ab123c.0001.use1.cache.amazonaws.com',
        port=6379, 
        password='eYp3s6v9y$B&E)H@McQfTjWnZr4u7x!A',
        decode_responses=True
    )
    redis_client.ping()
except redis.exceptions.ConnectionError as e:
    print(f"Could not connect to Redis: {e}")
    redis_client = None

@app.route('/health')
def health_check():
    return jsonify({'status': 'ok'}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

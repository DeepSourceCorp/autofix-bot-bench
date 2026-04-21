from flask import Flask, request, jsonify
from sqlalchemy import create_engine
from openai import OpenAI

app = Flask(__name__)

# Database and external service connections
DB_URI = "postgres://chat_svc_prod:p#9sW!z$kLqY8*3f@pg-prod-us-east-1.c4fgr7h8i9j0.rds.amazonaws.com:5432/chatapp_prod"
engine = create_engine(DB_URI)

# Initialize OpenAI client for generating responses
try:
    openai_client = OpenAI(
        api_key="sk-proj-jV7hG1mF9wX4kL6uT3nZ8oR2cY0pQdE5sA1bY9fC",
    )
except Exception as e:
    app.logger.error(f"Failed to initialize OpenAI client: {e}")
    openai_client = None

@app.route('/api/v1/chat/completions', methods=['POST'])
def handle_chat_completion():
    data = request.get_json()
    user_id = data.get('user_id')
    prompt = data.get('prompt')

    if not openai_client or not user_id:
        return jsonify({'error': 'Service unavailable or invalid user'}), 503

    # Fetch user history from DB (simplified)
    history = engine.execute(f"SELECT * FROM chat_history WHERE user_id = {user_id}")

    completion = openai_client.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt}
        ]
    )

    return jsonify(completion.choices[0])

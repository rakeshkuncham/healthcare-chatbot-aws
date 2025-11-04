import json
import boto3
import uuid
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('patient_chatbot_table')

def lambda_handler(event, context):
    user_message = event.get("inputTranscript", "")
    session_id = str(uuid.uuid4())

    # Dummy responses (later we integrate Lex logic)
    if "appointment" in user_message.lower():
        response = "Sure, please provide a date for your appointment."
    elif "hello" in user_message.lower():
        response = "Hello! I am your healthcare assistant. How can I help?"
    else:
        response = "I didn't understand. Can you please rephrase?"

    table.put_item(
        Item={
            "id": session_id,
            "query": user_message,
            "response": response,
            "timestamp": str(datetime.now())
        }
    )

    return {
        "statusCode": 200,
        "body": json.dumps({"reply": response})
    }

import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table("HealthcareChatbotUsers")

def lambda_handler(event, context):
    user_message = event['inputTranscript']
    
    if "medicine" in user_message.lower():
        reply = "Please consult a doctor before taking any medicine."
    else:
        reply = "Hello! I am your healthcare assistant. How can I help?"
    
    return {
        "sessionAttributes": {},
        "dialogAction": {
            "type": "Close",
            "fulfillmentState": "Fulfilled",
            "message": {"contentType": "PlainText","content": reply}
        }
    }

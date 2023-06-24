import os
import openai
openai.organization = "org-l9GqGTyn1y6BFwYBluQ9mzxt"
openai.api_key = "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"
MODEL = "gpt-3.5-turbo"
def reply_generate(MODEL,username, test_score):    
    response = openai.ChatCompletion.create(
        model = MODEL,
        messages=[
            {"role": "system", "content": "You are a teacher and need to give sudent persional reply with suggest based on their score. Student name is "+username},
            {"role": "user", "content": "The student got "+test_score+" in all the question test"},
        ],
        temperature=0,
    )

    return response['choices'][0]['message']['content']
from flask import Flask, request

app = Flask(__name__)

@app.route('/reply/')
def process_request():
    # Retrieve the parameters from the URL
    username = request.args.get('username')
    test_score = request.args.get('test_score')
    text = request.args.get('text')

    # Perform processing based on the parameters
    # For example, generate a reply
    reply = reply_generate(MODEL,username,test_score)

    # Return the reply as the response
    return reply


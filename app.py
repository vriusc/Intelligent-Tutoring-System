# Import the necessary libraries
import base64
import io
import os
import emit as emit
import openai
from flask_socketio import SocketIO, emit
from flask import Flask, request, render_template
from google.cloud import vision_v1
from PIL import Image
from google.cloud.vision_v1.services.image_annotator import client

# Initialize OpenAI API key and model
openai.organization = "org-l9GqGTyn1y6BFwYBluQ9mzxt"
openai.api_key = "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"
MODEL = "gpt-3.5-turbo"

# Set Google Cloud Vision API credentials
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'EmotionIdentification/MyKey.json'

# Initialize Flask app and SocketIO
app = Flask(__name__)
socketio = SocketIO(app, async_model='eventlet')

# Instantiate Google Cloud Vision API client
client = vision_v1.ImageAnnotatorClient()


# Function to generate response from OpenAI GPT model
def reply_generate(MODEL, username, test_score):
    response = openai.ChatCompletion.create(
        model=MODEL,
        messages=[
            {"role": "system",
             "content": "You are a teacher and need to give sudent persional reply with suggest based on their score. Student name is " + username},
            {"role": "user", "content": "The student got " + test_score + " in all the question test"},
        ],
        temperature=0,
    )
    return response['choices'][0]['message']['content']


# Route for GPT reply
@app.route('/gpt/reply', methods=['Post'])
def process_request():
    # Retrieve the parameters from the URL
    username = request.args.get('username')
    test_score = request.args.get('test_score')
    text = request.args.get('text')

    # Check if username or test_score is None
    if username is None or test_score is None:
        return 'Username or test score not provided', 400

    # Generate a reply
    reply = reply_generate(MODEL, username, test_score)
    return reply  # Return the reply as the response


# Home route
@app.route('/home')
def home():
    return render_template('index.html')

# SocketIO event for image
@socketio.on('image')
def image(data):
    # Receive and decode image from frontend
    image_data = base64.b64decode(data.split(",")[1])
    image = Image.open(io.BytesIO(image_data))
    # Emotion recognition
    imgByteArr = io.BytesIO()
    image.save(imgByteArr, format='PNG')
    imgByteArr = imgByteArr.getvalue()
    image = vision_v1.Image(content=imgByteArr)
    response = client.face_detection(image=image)
    faces = response.face_annotations
    # Loop over all detected faces
    for face in faces:
        # There may be multiple detected emotions, choose the one with highest confidence
        emotions = [(face.joy_likelihood, 'Happy'),
                    (face.sorrow_likelihood, 'Sad'),
                    (face.anger_likelihood, 'Angry'),
                    (face.surprise_likelihood, 'Normal'),
                    ]
        likely_emotion = max(emotions)[1]
        # If detected emotion is sadness, change it to confusion
        if likely_emotion == 'Sad':
            likely_emotion = 'Confused'

        # Send the recognition result to the frontend
        emit('response', likely_emotion)

# Route for testing
@app.route('/test')
def your_route_function():
    return render_template('Test.html')


# Run the Flask app
if __name__ == '__main__':
    socketio.run(app, debug=True, port=8080)

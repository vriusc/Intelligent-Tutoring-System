# Import the necessary libraries
import base64
import io
import os
import openai
from flask_socketio import SocketIO, emit
import emit as emit
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
def feedback_reply_generate(MODEL, username, test_score):
    response = openai.ChatCompletion.create(
        model=MODEL,
        messages=[
            {"role": "system",
             "content": "You are a tutor giving direct and informal feedback to your student, " + username + ", based on their test score."},
            {"role": "user", "content": "The student got " + test_score + " in all the question test. (Assuming a perfect score on all questions is ten)"},
        ],
        temperature=0,
    )
    return response['choices'][0]['message']['content']






# Route for GPT feedback reply
@app.route('/feedback/', methods=['Post'])
def process_feedback_request():
    # Retrieve the parameters from the URL
    username = request.args.get('username')
    test_score = request.args.get('test_score')
    text = request.args.get('text')

    # Check if username or test_score is None
    if username is None or test_score is None:
        return 'Username or test score not provided', 400

    # Generate a reply
    reply = feedback_reply_generate(MODEL, username, test_score)
    return reply  # Return the reply as the response


# This function uses the OpenAI GPT model to generate a reply,
# where the model plays the role of a tutor evaluating a student's essay.
def writing_reply_generate(MODEL, username, essay_topic, essay_content, essay_language):
    # Call the OpenAI API to generate a response.
    response = openai.ChatCompletion.create(
        model=MODEL,  # The specific model being used, e.g., "text-davinci-002"
        messages=[
            # The initial system message sets up the scenario.
            {"role": "system",
             "content": "You are a tutor who is evaluating a student's essay written in "
                        + essay_language
                        + ". The student's name is "
                        + username
                        + ". Use the following grading rubric for your assessment: \
                        1. Content (7 points): The essay should accurately and comprehensively address the topic. \
                        2. Organization (3 points): The essay should have a clear introduction, body, and conclusion. \
                        3. Grammar and Vocabulary (3 points): The essay should use correct grammar and sophisticated vocabulary. \
                        4. Creativity (2 points): The essay should provide a unique perspective or insights about the topic. \
                        5. Language Usage (5 points): The essay should be written appropriately in "
                        + essay_language
                        + ". Provide a score for each criteria and an overall score."},
            # The user message provides the essay topic and content for the model to evaluate.
            {"role": "user", "content": "Here's the essay topic and content: "
                                        + essay_topic
                                        + " and "
                                        + essay_content},
        ],
        # The temperature parameter controls the randomness of the model's output.
        temperature=0.7,
    )
    # The function returns the model's generated message content.
    return response['choices'][0]['message']['content']



# This route processes incoming requests to evaluate an essay.
@app.route('/writting/', methods=['Post'])
def process_writing_request():
    # Retrieve the parameters from the incoming request.
    username = request.args.get('username')
    essay_topic = request.args.get('essay_topic')
    essay_content = request.args.get('essay_content')
    essay_language = request.args.get('essay_language')

    # Check if any necessary parameters are missing.
    if username is None or essay_content is None or essay_topic is None:
        return 'Username, essay topic, or essay content not provided', 400

    # Generate a response using the writing_reply_generate function.
    reply = writing_reply_generate(MODEL, username, essay_topic, essay_content,essay_language)

    # Return the generated reply as the response.
    return reply






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

    if not faces:  # Check if any face is detected
        emit('response', None)
        return

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
    socketio.run(app, debug=True, port=5000, allow_unsafe_werkzeug=True)

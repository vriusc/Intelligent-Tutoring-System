# Import the necessary libraries
import base64
import io
import os
import emit as emit
from flask_socketio import SocketIO, emit



from flask import Flask,render_template
from google.cloud import vision_v1
from PIL import Image
from google.cloud.vision_v1.services.image_annotator import client



# Set Google Cloud Vision API credentials
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'EmotionIdentification/MyKey.json'

# Initialize Flask app and SocketIO
app = Flask(__name__)
socketio = SocketIO(app, async_model='eventlet')

# Instantiate Google Cloud Vision API client
client = vision_v1.ImageAnnotatorClient()



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
@app.route('/FaceRec')
def your_route_function():
    return render_template('FaceRecTest.html')


# Run the Flask app
if __name__ == '__main__':
    socketio.run(app, debug=True, port=5000)

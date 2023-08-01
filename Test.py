# Import the necessary libraries

from flask import Flask, request, jsonify

# Initialize OpenAI API key and model

from OpenAI_GPT_Tutor import OpenAI_GPT_Tutor
from OpenAI_Utilities import OpenAI_Utilities

# 使用方法：
key = b'PoLE4TnSm2Ys9QBeiNDJGuTkrl5NWap_He29jGQB3J8='
encrypted_file_path = 'encrypted_config.ini'
MODEL = "gpt-3.5-turbo"


OpenAI_Utilities.initialize_openai(key, encrypted_file_path, MODEL)


# Initialize Flask app
app = Flask(__name__)

def assess_learning_style(learning_activist,learning_reflector,learning_theorist,learning_pragmatist):
    # 获取学生的学习风格分数
    learning_activist = int(learning_activist)
    learning_reflector = int(learning_reflector)
    learning_theorist = int(learning_theorist)
    learning_pragmatist = int(learning_pragmatist)

    # 定义学习风格
    learning_style = "Mixed"
    max_score = max(learning_activist, learning_reflector, learning_theorist, learning_pragmatist)
    if max_score == learning_activist:
        learning_style = "Activist"
    elif max_score == learning_reflector:
        learning_style = "Reflector"
    elif max_score == learning_theorist:
        learning_style = "Theorist"
    elif max_score == learning_pragmatist:
        learning_style = "Pragmatist"

    # 为学生提供基于其学习风格的评价
    evaluation = f"The learning style seems to be predominantly {learning_style}."
    if learning_style == "Activist":
        evaluation += " The student learns best by doing and enjoys new experiences and challenges."
    elif learning_style == "Reflector":
        evaluation += " The student prefers to think about and analyze information before taking action."
    elif learning_style == "Theorist":
        evaluation += " The student enjoys understanding theories and underlying concepts."
    elif learning_style == "Pragmatist":
        evaluation += " The student is keen on trying out ideas and techniques to see if they work in practice."

    return evaluation



def validate_params(params):
    # Check if any required parameter is missing or None
    missing_params = [key for key, value in params.items() if value is None]
    if missing_params:
        error_message = f"Missing required parameters: {', '.join(missing_params)}"
        return False, error_message
    return True, None




@app.route('/gpt/feedback', methods=['POST'])
def process_feedback_request_with_validation():
    # Retrieve the parameters from the incoming request
    username = request.json.get('username')
    test_score = request.json.get('test_score')
    unit_description = request.json.get('unit_description')
    evaluation = request.json.get('evaluation')

    # Validate the required parameters
    is_valid, error_message = validate_params({
        'username': username,
        'test_score': test_score,
        'unit_description': unit_description,
        'evaluation': evaluation
    })
    if not is_valid:
        return jsonify({"error": error_message}), 400  # Return 400 Bad Request if validation fails

    # Create an instance of the OpenAI_GPT_Tutor class
    tutor = OpenAI_GPT_Tutor(MODEL)

    # Generate a reply
    reply = tutor.feedback_reply_generate(username, test_score, unit_description, evaluation)

    return reply  # Return the reply as the response

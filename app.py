# Import the necessary libraries
import openai
from flask import Flask, request

# Initialize OpenAI API key and model
from cryptography.fernet import Fernet
import configparser



# 你之前保存的密钥
key = b'PoLE4TnSm2Ys9QBeiNDJGuTkrl5NWap_He29jGQB3J8='

# 使用密钥创建Fernet密码器
cipher_suite = Fernet(key)

# 读取加密文件
with open('encrypted_config.ini', 'rb') as file:
    cipher_text = file.read()

# 解密数据
decrypted_data = cipher_suite.decrypt(cipher_text)

# 使用ConfigParser解析解密后的数据
config = configparser.ConfigParser()
config.read_string(decrypted_data.decode())

openai_api_key = config['openai']['api_key']
openai_organization = config['openai']['organization']

# 初始化OpenAI库
openai.organization = openai_organization
openai.api_key = openai_api_key


MODEL = "gpt-3.5-turbo"



# Initialize Flask app
app = Flask(__name__)


# Function to generate response from OpenAI GPT model
def feedback_reply_generate(MODEL, username, test_score, unit_description, evaluation):
    response = openai.ChatCompletion.create(
        model=MODEL,
        messages=[
            {
                "role": "system",
                "content": "You are a language tutor providing feedback to your student, " + username + ". "
                + "Assess their performance in a test, focusing on their score of " + test_score + " in the unit '" + unit_description + "'. "
                + "Consider their learning style evaluation of " + evaluation + ". "
                + "Provide concise feedback without using a formal letter format. Focus on the specific details of the test and avoid unrelated content."
            },
            {
                "role": "user",
                "content": "The student scored " + test_score + " in the test on " + unit_description + ".(Assuming a max score on all questions is five)"
            },
        ],
        temperature=0,
    )
    return response['choices'][0]['message']['content']



def answer_reply_generate(MODEL, username, subject, unit, unit_description, question, question_description, student_question):
    response = openai.ChatCompletion.create(
        model=MODEL,
        messages=[
            {
                "role": "system",
                "content": f"You are a tutor specialized in the subject {subject}, assisting students with their studies. Your student, {username}, is currently working on unit {unit}, described as '{unit_description}'. They are focused on the following question: '{question_description}', and have encountered difficulties. Provide a detailed and specific answer to their question without addressing unrelated content."
            },
            {
                "role": "user",
                "content": f"The student is stuck on the following question: '{question}'. They are asking: '{student_question}'"
            },
        ],
        temperature=0.7,
    )
    return response['choices'][0]['message']['content']






# This function uses the OpenAI GPT model to generate a reply,
# where the model plays the role of a tutor evaluating a student's essay.
def writing_reply_generate(MODEL, username, essay_topic, essay_content, essay_language, evaluation):
    # Call the OpenAI API to generate a response.
    response = openai.ChatCompletion.create(
        model=MODEL,
        messages=[
            {
                "role": "system",
                "content": f"You are a tutor specialized in evaluating student essays written in {essay_language}. You are assessing an essay by {username}, following these guidelines and {evaluation}: \
                            1. Content (7 points): Address the topic accurately and comprehensively.<br />\
                            2. Organization (3 points): Include a clear introduction, body, and conclusion.<br />\
                            3. Grammar and Vocabulary (3 points): Use correct grammar and sophisticated vocabulary.<br />\
                            4. Creativity (2 points): Provide a unique perspective or insights about the topic.<br />\
                            5. Language Usage (5 points): Write appropriately in {essay_language}.<br />\
                            Provide a score for each criteria and an overall score. Focus on these criteria and avoid unrelated content."
            },
            {
                "role": "user",
                "content": f"Here's the essay topic and content: {essay_topic} and {essay_content}"
            },
        ],
        temperature=0.7,
    )

    # Extract the original response
    original_response = response['choices'][0]['message']['content']

    # Break the original response into paragraphs based on your specific criteria
    paragraphs = original_response.split('\n')

    # Concatenate the paragraphs with HTML line break tag
    formatted_response = "<br />".join(paragraphs)

    return formatted_response


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




# Route for GPT feedback reply
@app.route('/gpt/feedback', methods=['Post'])
def process_feedback_request():
    # Retrieve the parameters from the URL

    username = request.json.get('username')
    test_score = request.json.get('test_score')
    unit_description = request.json.get('unit_description')
    learning_activist = request.json.get('activist')
    learning_reflector = request.json.get('reflector')
    learning_theorist = request.json.get('theorist')
    learning_pragmatist = request.json.get('pragmatist')

    if learning_activist is None and learning_reflector is None and learning_theorist is None and learning_pragmatist is None:
        evaluation = " "

    else:
        evaluation = assess_learning_style(learning_activist,learning_reflector,learning_theorist,learning_pragmatist)

    # Check if username or test_score is None
    if username is None or test_score is None or unit_description is None:
        return 'Username or test score not provided', 400

    # Generate a reply
    reply = feedback_reply_generate(MODEL, username, test_score,unit_description, evaluation)
    return reply  # Return the reply as the response



# Route for GPT feedback reply
@app.route('/gpt/question', methods = ['Post'])
def process_question_request():
    # 获取学生的问题和上下文信息

    username = request.json.get('username')
    subject = request.json.get('subject')
    unit = request.json.get('unit')
    unit_description = request.json.get('unit_description')
    question = request.json.get('question')
    question_description = request.json.get('question_description')
    student_question = request.json.get('student_question')

    # Check if username or test_score is None
    if username is None or student_question is None or subject is None or unit is None or unit_description is None or question is None or question_description is None:
        return 'Username or user question not provided', 400

    # Generate a reply
    reply = answer_reply_generate(MODEL, username, subject, unit, unit_description, question, question_description, student_question)


    return reply  # Return the reply as the response





# This route processes incoming requests to evaluate an essay.
@app.route('/gpt/writting', methods=['Post'])
def process_writing_request():
    # Retrieve the parameters from the incoming request.

    username = request.json.get('username')
    essay_topic = request.json.get('essay_topic')
    essay_content = request.json.get('essay_content')
    essay_language = request.json.get('essay_subject')  # 注意，这里我保留了您原来的键名 'essay_subject'

    learning_activist = request.json.get('activist')
    learning_reflector = request.json.get('reflector')
    learning_theorist = request.json.get('theorist')
    learning_pragmatist = request.json.get('pragmatist')

    if learning_activist is None and learning_reflector is None and learning_theorist is None and learning_pragmatist is None:
        evaluation = " "

    else:
        evaluation = assess_learning_style(learning_activist, learning_reflector, learning_theorist, learning_pragmatist)

    # Check if any necessary parameters are missing.
    if username is None or essay_content is None or essay_topic is None:
        return 'Username, essay topic, or essay content not provided', 400

    # Generate a response using the writing_reply_generate function.
    reply = writing_reply_generate(MODEL, username, essay_topic, essay_content,essay_language, evaluation)

    # Return the generated reply as the response.
    return reply




# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True, port=8080)

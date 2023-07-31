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



# Route for GPT feedback reply
@app.route('/gpt/feedback', methods=['Post'])
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


# This route processes incoming requests to evaluate an essay.
@app.route('/gpt/writting', methods=['Post'])
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



# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True, port=8080)

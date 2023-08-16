# Import the required libraries
import openai

# Define the OpenAI_GPT_Tutor class, which handles interactions with the OpenAI GPT model
class OpenAI_GPT_Tutor:
    def __init__(self, model):
        """
        Initialize the tutor with the specified model.
        :param model: The name of the OpenAI GPT model to be used.
        """
        self.model = model

    def _generate_reply(self, system_message, user_message, temperature=0.7):
        """
        General function to generate a reply using OpenAI GPT model.
        :param system_message: The system message that sets up the scenario.
        :param user_message: The user message that provides specific details.
        :param temperature: The randomness of the model's output (default 0.7).
        :return: The generated reply content.
        """
        # Generate a reply using the OpenAI GPT model
        response = openai.ChatCompletion.create(
            model=self.model,
            messages=[
                {"role": "system", "content": system_message},
                {"role": "user", "content": user_message},
            ],
            temperature=temperature,
        )
        # Return the generated reply
        return response['choices'][0]['message']['content']

    def feedback_reply_generate(self, username, user_prefer_language, all_question_description, all_question_option_description, wrong_answer_number, subject, test_score, unit_description, evaluation):
        """
        Generate feedback for a student's test score.
        :param username: The student's username.
        :param user_prefer_language: The student's preferred language for receiving feedback.
        :param all_question_description: Description of all questions in the test.
        :param all_question_option_description: Description of all options provided for the questions.
        :param wrong_answer_number: The numbers of the questions the student answered incorrectly.
        :param subject: The subject of the test.
        :param test_score: The student's test score.
        :param unit_description: Description of the unit related to the test.
        :param evaluation: Evaluation of the student's learning style.
        :return: The generated feedback content.
        """
        # Generate feedback based on the student's test score and return it
        system_message = (f"Answer in the user's preferred language. {user_prefer_language}. You must translate the following standards as an answer if the user's preferred language is not English."
                f"You are a language tutor providing feedback to your student, {username}. "
                f"Assess their performance in a test on {subject}, focusing on their score of {test_score} in the unit '{unit_description}'. "
                f"Consider the specific questions: {all_question_description}, and the options provided: {all_question_option_description}. "
                f"Take note of the wrong answers: {wrong_answer_number}. "
                f"Consider their learning style evaluation of {evaluation}. "
                f"Provide concise feedback without using a formal letter format. Focus on the specific details of the test and avoid unrelated content.")
        user_message = (f"The student got {test_score} in all the question test. "
                        f"{unit_description} (Assuming a perfect score on all questions is five)")

        return self._generate_reply(system_message, user_message, temperature = 0.7)

    def answer_reply_generate(self, username, user_prefer_language,subject, unit, unit_description, question, question_description, option_description,student_question, evaluation):
        """
        Generate an answer for a student's question in a specific subject.
        :param username: The student's username.
        :param user_prefer_language: The student's preferred language for receiving answers.
        :param subject: The subject of the question (e.g., Math, Science).
        :param unit: The unit the student is studying.
        :param unit_description: Description of the unit related to the question.
        :param question: The question number.
        :param question_description: The description of the question.
        :param option_description: The description of the options for the question.
        :param student_question: The student's question.
        :param evaluation: Guidelines for evaluating the student's learning style.
        :return: The generated answer content.
        """
        # Generate a detailed and specific answer to the student's question and return it
        system_message = (f"Answer in the user's preferred language. {user_prefer_language}. You must translate the following standards as an answer if the user's preferred language is not English."
                          f"You are a tutor specialized in the subject {subject}, assisting students with their studies. Your student, {username}, is currently working on unit {unit}, described as '{unit_description}'. They are focused on the following question: '{question_description} and option :{option_description}', and have encountered difficulties. Provide a detailed and specific answer to their question without addressing unrelated content. Answer in the user's preferred language. {user_prefer_language}"
                          f"Consider their learning style evaluation of {evaluation}. " )
        user_message = f"The student is stuck on the following question: '{question}'. They are asking: '{student_question}'"
        return self._generate_reply(system_message, user_message,temperature = 0.7)

    def writing_reply_generate(self, username, user_prefer_language, essay_topic, essay_content, essay_language, evaluation):
        """
        Evaluate a student's essay on a specific topic and language.
        :param username: The student's username.
        :param user_prefer_language: The student's preferred language for receiving feedback.
        :param essay_topic: The topic of the essay.
        :param essay_content: The content of the essay.
        :param essay_language: The language of the essay.
        :param evaluation: Guidelines for evaluating the essay.
        :return: The generated evaluation content.
        """
        # Generate an evaluation of the student's essay based on specified criteria and return it
        system_message = ( f"Answer in the user's preferred language. {user_prefer_language}. You must translate the following standards as an answer if the user's preferred language is not English."
                           f"You are a tutor specialized in evaluating student essays written in {essay_language}. You are assessing an essay by {username}, following these guidelines and {evaluation}: \
                            1. Content (7 points): Address the topic accurately and comprehensively.<br />\
                            2. Organization (3 points): Include a clear introduction, body, and conclusion.<br />\
                            3. Grammar and Vocabulary (3 points): Use correct grammar and sophisticated vocabulary.<br />\
                            4. Creativity (2 points): Provide a unique perspective or insights about the topic.<br />\
                            5. Language Usage (5 points): Write appropriately in {essay_language}.<br />\
                            Provide a score for each criteria and an overall score. Focus on these criteria and avoid unrelated content. ")

        user_message = f"Here's the essay topic and content: {essay_topic} and {essay_content}"
        return self._generate_reply(system_message, user_message,temperature = 0.7)

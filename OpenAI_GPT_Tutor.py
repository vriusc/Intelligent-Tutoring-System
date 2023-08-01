# Class to handle interactions with OpenAI GPT model
import openai


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
        # General function to generate a reply using OpenAI GPT model
        response = openai.ChatCompletion.create(
            model=self.model,
            messages=[
                {"role": "system", "content": system_message},
                {"role": "user", "content": user_message},
            ],
            temperature=temperature,
        )
        return response['choices'][0]['message']['content']

    def feedback_reply_generate(self, username, test_score, unit_description, evaluation):
        """
        Generate feedback for a student's test score.
        :param username: The student's username.
        :param test_score: The student's test score.
        :param unit_description: Description of the unit related to the test.
        :param evaluation: Evaluation of the student's learning style.
        :return: The generated feedback content.
        """
        # Specific function to generate feedback for a test score
        system_message = (f"You are a language tutor providing specific feedback to your student, {username}. "
                          f"You are to assess their performance in a test, focusing on their score of {test_score} "
                          f"and considering their learning style evaluation of {evaluation}. "
                          "Please provide detailed and focused feedback on the test related to the unit "
                          f"'{unit_description}'. Avoid addressing unrelated content or questions.")
        user_message = (f"The student got {test_score} in all the question test. "
                        f"{unit_description} (Assuming a perfect score on all questions is five)")
        return self._generate_reply(system_message, user_message, temperature=0)

    def answer_reply_generate(self, subject, student_question):
        """
        Generate an answer for a student's question in a specific subject.
        :param subject: The subject of the question (e.g., Math, Science).
        :param student_question: The student's question.
        :return: The generated answer content.
        """
        system_message = f"You are a tutor specialized in {subject}. Answer the following student's question.Focus on these criteria and avoid unrelated content."
        user_message = student_question
        return self._generate_reply(system_message, user_message)

    def writing_reply_generate(self, username, essay_topic, essay_content, essay_language, evaluation):
        """
        Evaluate a student's essay on a specific topic and language.
        :param username: The student's username.
        :param essay_topic: The topic of the essay.
        :param essay_content: The content of the essay.
        :param essay_language: The language of the essay.
        :param evaluation: Guidelines for evaluating the essay.
        :return: The generated evaluation content.
        """
        system_message = (f"You are a tutor specialized in evaluating student essays written in {essay_language}. "
                          f"You are assessing an essay by {username}, following these guidelines and {evaluation}: "
                          "1. Content (7 points): Address the topic accurately and comprehensively. "
                          "2. Organization (3 points): Include a clear introduction, body, and conclusion. "
                          "3. Grammar and Vocabulary (3 points): Use correct grammar and sophisticated vocabulary. "
                          "4. Creativity (2 points): Provide a unique perspective or insights about the topic. "
                          "5. Language Usage (5 points): Write appropriately in {essay_language}. "
                          "Provide a score for each criteria and an overall score. Focus on these criteria and avoid unrelated content.")
        user_message = f"Here's the essay topic and content: {essay_topic} and {essay_content}"
        return self._generate_reply(system_message, user_message)

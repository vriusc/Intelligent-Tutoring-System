from OpenAI_Config import OpenAI_Config


class OpenAI_Utilities:
    @staticmethod
    def initialize_openai(encryption_key, encrypted_file_path, model_name):
        config_handler = OpenAI_Config(encryption_key, encrypted_file_path, model_name)
        config_handler.initialize_openai()
        print("OpenAI initialization complete.")



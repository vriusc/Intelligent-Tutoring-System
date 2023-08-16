from OpenAI_Config import OpenAI_Config


class OpenAI_Utilities:
    """
    Utility class for OpenAI operations.
    """

    @staticmethod
    def initialize_openai(encryption_key, encrypted_file_path, model_name):
        """
        Initialize the OpenAI library by decrypting the encrypted configuration file and setting up the API key and organization ID.

        :param encryption_key: The encryption key used to decrypt the configuration file.
        :param encrypted_file_path: The path to the encrypted configuration file.
        :param model_name: The name of the OpenAI GPT model to use.
        """
        # Create an instance of the OpenAI_Config class
        config_handler = OpenAI_Config(encryption_key, encrypted_file_path, model_name)

        # Initialize the OpenAI library with the decrypted API key and organization ID
        config_handler.initialize_openai()

        # Print a confirmation message
        print("OpenAI initialization complete.")

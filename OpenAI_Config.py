from cryptography.fernet import Fernet
import configparser
import openai

class OpenAI_Config:
    def __init__(self, encryption_key, encrypted_file_path, model_name):
        """
        Initialize the OpenAI_Config class.
        :param encryption_key: The encryption key used to decrypt the configuration file.
        :param encrypted_file_path: The path to the encrypted configuration file.
        :param model_name: The name of the OpenAI GPT model to use.
        """
        self.key = encryption_key
        self.encrypted_file_path = encrypted_file_path
        self.model_name = model_name
        self.openai_api_key = None
        self.openai_organization = None

        self._read_and_decrypt_config()

    def _read_and_decrypt_config(self):
        """
        Read the encrypted configuration file, decrypt it, and store the API key and organization ID as class variables.
        """
        # Create a Fernet cipher suite using the provided encryption key
        cipher_suite = Fernet(self.key)

        # Read the encrypted file
        with open(self.encrypted_file_path, 'rb') as file:
            cipher_text = file.read()

        # Decrypt the data
        decrypted_data = cipher_suite.decrypt(cipher_text)

        # Use ConfigParser to parse the decrypted data
        config = configparser.ConfigParser()
        config.read_string(decrypted_data.decode())

        self.openai_api_key = config['openai']['api_key']
        self.openai_organization = config['openai']['organization']

    def initialize_openai(self):
        """
        Initialize the OpenAI library with the decrypted API key and organization ID.
        """
        # Set the OpenAI library's organization and API key
        openai.organization = self.openai_organization
        openai.api_key = self.openai_api_key

# Usage：
# Define the encryption key, encrypted file path, and model name
# key = b'PoLE4TnSm2Ys9QBeiNDJGuTkrl5NWap_He29jGQB3J8='
# encrypted_file_path = 'encrypted_config.ini'
# model_name = "gpt-3.5-turbo"

# Create an instance of the OpenAI_Config class and initialize OpenAI
# config_handler = OpenAI_Config(key, encrypted_file_path, model_name)
# config_handler.initialize_openai()

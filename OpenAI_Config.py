from cryptography.fernet import Fernet
import configparser
import  openai

class OpenAI_Config:
    def __init__(self, encryption_key, encrypted_file_path, model_name):
        self.key = encryption_key
        self.encrypted_file_path = encrypted_file_path
        self.model_name = model_name
        self.openai_api_key = None
        self.openai_organization = None

        self._read_and_decrypt_config()

    def _read_and_decrypt_config(self):
        # 使用密钥创建Fernet密码器
        cipher_suite = Fernet(self.key)

        # 读取加密文件
        with open(self.encrypted_file_path, 'rb') as file:
            cipher_text = file.read()

        # 解密数据
        decrypted_data = cipher_suite.decrypt(cipher_text)

        # 使用ConfigParser解析解密后的数据
        config = configparser.ConfigParser()
        config.read_string(decrypted_data.decode())

        self.openai_api_key = config['openai']['api_key']
        self.openai_organization = config['openai']['organization']

    def initialize_openai(self):
        # 初始化OpenAI库
        openai.organization = self.openai_organization
        openai.api_key = self.openai_api_key

# 使用方法：
key = b'PoLE4TnSm2Ys9QBeiNDJGuTkrl5NWap_He29jGQB3J8='
encrypted_file_path = 'encrypted_config.ini'
model_name = "gpt-3.5-turbo"

config_handler = OpenAI_Config(key, encrypted_file_path, model_name)
config_handler.initialize_openai()

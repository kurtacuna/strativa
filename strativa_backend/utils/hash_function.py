import hashlib
from dotenv import load_dotenv
import os

dotenv_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), '.env.development')
load_dotenv(dotenv_path=dotenv_path)

hash_salt = os.getenv('HASH_SALT')

def hash_data(data):
    data = data + hash_salt
    hasher = hashlib.sha256()
    hasher.update(data.encode('utf-8'))
    return hasher.hexdigest()


if __name__ == "__main__":
    while True:
        user_input = input("enter data: ")
        print("to store in db: " + hash_data(user_input))
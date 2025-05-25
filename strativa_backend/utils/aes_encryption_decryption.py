from Crypto.Cipher import AES
from dotenv import load_dotenv
import os
import base64

dotenv_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), '.env.development')
load_dotenv(dotenv_path=dotenv_path)

# Secret key in .env
key = base64.urlsafe_b64decode(os.getenv('ENC_DEC_KEY').encode('utf-8'))

def encrypt(data: str):
    """
    param data: the piece of data to encrypt
    return: returns tuple of nonce, ciphertext, and tag to store in the database
    """

    data = str(data)

    cipher = AES.new(key, AES.MODE_GCM)
    nonce = cipher.nonce
    ciphertext, tag = cipher.encrypt_and_digest(data.encode('utf-8'))

    # Encode to base64
    nonce = base64.urlsafe_b64encode(nonce).decode('utf-8')
    ciphertext = base64.urlsafe_b64encode(ciphertext).decode('utf-8')
    tag = base64.urlsafe_b64encode(tag).decode('utf-8')
    return f"{nonce}:{ciphertext}:{tag}"


def decrypt(data):
    """
        param nonce, ciphertext, tag: comes from the database
        return: the plaintext if verified, otherwise, raise an error
    """
    data = str(data)

    if len(data.split(":")) == 1:
        return data

    nonce, ciphertext, tag = data.split(':')

    # Decode from base64
    nonce = base64.urlsafe_b64decode(nonce.encode('utf-8'))
    ciphertext = base64.urlsafe_b64decode(ciphertext.encode('utf-8'))
    tag = base64.urlsafe_b64decode(tag.encode('utf-8'))

    cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
    try:
        plaintext_bytes = cipher.decrypt_and_verify(ciphertext, tag)
        return plaintext_bytes.decode('utf-8')
    except Exception as e:
        print(e)
        raise


if __name__ == "__main__":
    while True:
        data = encrypt(input("enter data: "))
        nonce, ciphertext, tag = data.split(":")
        plaintext = decrypt(data)
        print(f"to store in db: {nonce}:{ciphertext}:{tag}")
        print(f"plaintext: {plaintext}")
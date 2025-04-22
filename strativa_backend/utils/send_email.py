import smtplib
from email.message import EmailMessage
from dotenv import load_dotenv, find_dotenv
import os

dotenv_path = find_dotenv(filename='.env.development')
load_dotenv(dotenv_path=dotenv_path)

def send_email(subject, message, recipients):
    server_email = os.getenv('SERVER_EMAIL')
    server_email_password = os.getenv('SERVER_EMAIL_PASSWORD')

    msg = EmailMessage()
    msg['Subject'] = subject
    msg['From'] = server_email
    msg['To'] = ', '.join(recipients)
    msg.set_content(message)

    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(user=server_email, password=server_email_password)
    server.sendmail(
        from_addr=server_email,
        to_addrs=recipients,
        msg=msg.as_string(),
    )
    server.quit()
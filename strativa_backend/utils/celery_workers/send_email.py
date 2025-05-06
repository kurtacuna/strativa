import smtplib
from email.message import EmailMessage
from dotenv import load_dotenv
import os
from celery import shared_task
from time import sleep

# Construct the path to the .env.development file in the parent directory
dotenv_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), '.env.development')
load_dotenv(dotenv_path=dotenv_path)

@shared_task
def send_email(subject, message, recipients):
    server_email = os.getenv('SERVER_EMAIL')
    server_email_password = os.getenv('SERVER_EMAIL_PASSWORD')

    msg = EmailMessage()
    msg['Subject'] = subject
    msg['From'] = server_email
    msg['To'] = ', '.join(recipients)
    msg.set_content(message)

    try:
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(user=server_email, password=server_email_password)
        server.sendmail(
            from_addr=server_email,
            to_addrs=recipients,
            msg=msg.as_string(),
        )
        server.quit()
        print("Email sent successfully!")
    except Exception as e:
        print(f"Error sending email: {e}")
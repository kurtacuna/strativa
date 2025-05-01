from celery import Celery

# redis:6379 because redis is the name of the service and 6379 is the exposed port
app = Celery(
    'strativa_backend',
    broker='redis://redis:6379',
    backend='redis://redis:6379',
    include=[
        'utils.celery_workers.send_email'
    ]
)

# Automatically delete results stored in reddit after some time
app.conf.update(
    result_expires=300,
)

# Automatically load task modules named tasks.py from installed Django apps
app.autodiscover_tasks()

if __name__ == '__main__':
    app.start()
import os
import subprocess

def restart_db(project_path):
    if not os.path.isdir(project_path):
        print(f"Invalid project path: {project_path}")
        exit(1)

    for root, dirs, files in os.walk(project_path):
        if 'strativa_venv' in dirs:
            dirs.remove('strativa_venv')

        if 'db.sqlite3' in files:
            try: 
                db_path = os.path.join(root, 'db.sqlite3')
                os.remove(db_path)
                print(f"Removed: {db_path}")
                # print(db_path)
            except Exception as e:
                print(f"Error: {e}")
                exit(1)

        if 'migrations' in dirs:
            migrations_path = os.path.join(root, 'migrations')
            for filename in os.listdir(migrations_path):
                if filename.endswith('.py') and filename != '__init__.py':
                    file_path = os.path.join(migrations_path, filename)
                    try:
                        os.remove(file_path)
                        # print(file_path)
                        print(f"Removed: {file_path}")
                    except Exception as e:
                        print(f"Error: {e}")
                        exit(1)
    
    try:
        bash_command = (
            "python manage.py makemigrations && "
            "python manage.py migrate && "
            "django-admin loaddata pre_load_db"
        )

        powershell_command = (
            "python manage.py makemigrations; "
            "python manage.py migrate; "
            "django-admin loaddata pre_load_db"
        )

        if os.name == 'posix':
            subprocess.run(["bash", "-c", bash_command], check=True)
        elif os.name == 'nt': # For windows
            subprocess.run(["powershell", "-Command", powershell_command], check=True)

        print("Database Restarted")
    except subprocess.CalledProcessError as e:
        print(f"Error while restarting db: {e}")




if __name__ == "__main__":
    script_file_path = os.path.dirname(os.path.abspath(__file__))
    restart_db(script_file_path)
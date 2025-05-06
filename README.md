<b>To run the backend, execute <code>docker-compose up</code> in the strativa_backend directory.</b>

To clone, change directory to the desired directory and execute:<br>
    <code>git clone https://github.com/kurtacuna/strativa.git</code>

To create a feature branch, navigate to the repository and execute:<br>
    <code>git branch -b branchname</code>

To install the dependencies needed in Flutter, change directory to <code>strativa_frontend</code> and execute:<br>
    <code>flutter pub get</code><br>
alternatively:<br>
    <code>flutter pub get -C path/to/strativa_frontend</code>

To install the dependencies needed in Django, change directory to strativa_backend and execute:<br>
    <code>pip install -r requirements.txt</code><br>
alternatively:<br>
    <code>pip install -r path/to/requirements.txt</code>


Steps for pushing:
1. Fork this repository to your own account.
2. Clone the repository in your account.
3. Create feature branch before commiting.
4. Push to your own repository.
5. Create a pull request to this repository.

Also, create a <code>.gitignore</code> file inside <code>strativa_frontend</code> and <code>strativa_backend</code> and then copy the the contents of each folder's <code>gitignore.txt</code> file into its respective <code>.gitignore</code> file.

Steps for forking:
1. Go to this repository and fork it.
2. Execute <code>git remote -v</code>. This should show this repository's link.
3. Execute <code>git remote set-url origin <your_forked_repository></code>.
4. Now, when you pull or push, it should be to your forked repository.

Steps for creating a pull request:
1. Go to your forked repository.
2. Navigate to the pull request tab, and create a new pull request.
3. Specify the title and details. Then, create pull request.

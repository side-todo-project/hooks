from flask import Flask
import os

app = Flask(__name__)

@app.route('/postreceive_frontend', methods=['POST'])
def front():
    os.system("./hooks-frontend-ci.sh")
    return 'Success!'


@app.route('/postreceive_backend', methods=['POST'])
def back():
    os.system("./hooks-backend-ci.sh")
    return 'Success!'


if __name__ == "__main__":
    app.run()

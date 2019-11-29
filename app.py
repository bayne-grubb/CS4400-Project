from flask import Flask, redirect, render_template, request


app = Flask(__name__)


@app.route("/")
def index():
    return render_template('login.html')
@app.route("/register")
def register():
    return render_template(url_for('register-navigation'))




if __name__ == '__main__':
    app.run()

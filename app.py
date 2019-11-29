from flask import Flask, redirect, render_template, request


app = Flask(__name__)


@app.route("/")
def index():
    return render_template('login.html')
@app.route("/manCusReg/", methods=['POST']) # make sure the requests are the right type(get,post etc.)
def manCusReg():
    #do stuff i.e.
    obj = request.get_json() # the data you send from front end
    fname = obj['fname'] # do this with all of the params
    # now you have the data, pass it to pymysql
    return obj # need to return a response just to make it not fail
@app.route("/manCusRegNav")
def manCusRegNav():
    return render_template('manager-customer-registration.html')

if __name__ == '__main__':
    app.run()

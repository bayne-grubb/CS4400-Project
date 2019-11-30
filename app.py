
from flask import Flask, g, redirect, render_template, request, url_for, flash
import database_test
import json

app = Flask(__name__)
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

# ROUTES
@app.route("/", methods=['GET','POST'])
def index():
    return render_template('login.html')

@app.route("/manCusReg")
def manCusReg():
    return render_template('manager-customer-registration.html')
@app.route("/adminCompanyDetail")
def adminCompanyDetail():
    return render_template('admin-company-detail.html')
@app.route("/createMovie")
def createMovie():
    return render_template('admin-create-movie.html')
@app.route("/adminCusFunc")
def adminCusFunc():
    return render_template('admin-customer-functionality.html')
@app.route("/adminFunc")
def adminFunc():
    return render_template('admin-only-functionality.html')
@app.route("/createTheater")
def createTheater():
    return render_template('create-theater.html')
@app.route("/cusExpMovie")
def cusExpMovie():
    return render_template('customer-explore-movie.html')
@app.route("/cusFunc")
def cusFunc():
    return render_template('customer-functionality.html')
@app.route("/cusReg", methods=['GET','POST'])
def cusReg():
    return render_template('customer-registration.html')
@app.route("/manageUser")
def manageUser():
    return render_template('manage-user.html')
@app.route("/manCusFunc")
def manCusFunc():
    return render_template('manager-customer-functionality.html')
@app.route("/manFunc")
def manFunc():
    return render_template('manager-only-functionality.html')
@app.route("/manReg", methods=['GET','POST'])
def manReg():
    return render_template('manager-registration.html')
@app.route("/manScheduleMovie")
def manScheduleMovie():
    return render_template('manager-schedule-movie.html')
@app.route("/manTheaterOverview")
def manTheaterOverview():
    return render_template('manager-theater-overview.html')
@app.route("/regNav", methods=['GET','POST'])
def regNav():
    return render_template('register-navigation.html')
# @app.route("/loginNav", methods=['GET', 'POST'])
# def loginNav():
#     if request.method == 'POST':
#         g.username = request.form['uname']
#         g.password = request.form['psw']
#         rows = json.loads(database_test.user_login(g.username, g.password))
#         try:
#             row = rows[0]
#         except:
#             flash('Invalid login!')
#             return render_template('login.html')
#         is_customer = row['isCustomer']
#         is_admin = row['isAdmin']
#         is_manager = row['isManager']
#         if is_customer:
#             if is_admin:
#                 return redirect('/adminCusFunc')
#             elif is_manager:
#                 return redirect('/manCusFunc')
#             else:
#                 return redirect('/cusFunc')
#         elif is_admin:
#             return redirect('/adminFunc')
#         else:
#             return redirect('/manFunc')
@app.route("/userExploreTheater")
def userExploreTheater():
    return render_template('user-explore-theater.html')
@app.route("/userFunc")
def userFunc():
    return render_template('user-functionality.html')
@app.route("/userReg", methods=['GET','POST'])
def userReg():
    return render_template('user-registration.html')
@app.route("/userVisitHistory")
def userVisitHistory():
    return render_template('user-visit-history.html')
@app.route("/viewHistory")
def viewHistory():
    return render_template('view-history.html')


#functions
# will make each type of request one function (one function for post, one for get, one for put, one for delete)
# to do this need to pass stored procedure name from front end and store params in a
# tuple and pass to db using pymysql

@app.route("/manCusRegi/", methods=['POST']) # make sure the requests are the right type(get,post etc.)
def manCusRegi():
    #do stuff i.e.
    obj = request.get_json() # the data you send from front end
    fname = obj['fname'] # do this with all of the params
    # now you have the data, pass it to pymysql
    return obj # need to return a response just to make it not fail
if __name__ == '__main__':
    app.run()

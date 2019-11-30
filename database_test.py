import pymysql
from flask import current_app, Flask
import json
import datetime

def setup_connection():
    con = pymysql.connect('localhost', 'root', '', 'team13', cursorclass=pymysql.cursors.DictCursor)
    return con, con.cursor()

# Retrieving Data #

def get_table(table):
    con, cur = setup_connection()
    cur.execute('SELECT * from {}'.format(table))
    for row in cur.fetchall():
        print(row)


# get_table('User')
# get_table('Employee')

# A stored procedure
def user_login(username, password):
    con, cur = setup_connection()
    cur.callproc('user_login', (username, password))
    cur.execute('SELECT * FROM UserLogin')
    con.commit()
    return json.dumps(cur.fetchall())


# print(user_login('calcultron', '333333333'))

def user_register(username, password, firstname, lastname):
    con, cur = setup_connection()
    try:
        cur.callproc('user_register', (username, password, firstname, lastname))
        con.commit()
    except:
        return json.dumps({'success':False}), 400, {'ContentType': 'application/json'}
    return json.dumps({'success':True}), 200, {'ContentType':'application/json'}

# print(user_register('calcultron', 'asdkljfdslfds', 'fname', 'lname'))

def customer_only_register(username, password, firstname, lastname):
    con,cur = setup_connection()
    try:
        cur.callproc('customer_only_register', (username, password, firstname, lastname))
        con.commit()
    except:
        return json.dumps({'success':False}), 400, {'ContentType': 'application/json'}
    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}


def customer_add_creditcard(username, credit_card_num):
    con, cur = setup_connection()
    cur.callproc('customer_add_creditcard', (username, credit_card_num))
    con.commit()
    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}


def manager_only_register(username, password, firstname, lastname, com_name, emp_street, emp_city, emp_state, emp_zip):
    con, cur = setup_connection()
    try:
        cur.callproc('manager_only_register',
                 (username, password, firstname, lastname, com_name, emp_street, emp_city, emp_state, emp_zip))
        con.commit()
    except:
        return json.dumps({'success':False}), 400, {'ContentType': 'application/json'}
    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}


def manager_customer_register(username, password, firstname, lastname, com_name, emp_street, emp_city, emp_state,
                              emp_zip):
    con, cur = setup_connection()
    try:
        cur.callproc('manager_customer_register',
                 (username, password, firstname, lastname, com_name, emp_street, emp_city, emp_state, emp_zip))
        con.commit()
    except:
        return json.dumps({'success':False}), 400, {'ContentType': 'application/json'}
    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}


def admin_approve_user(username):
    con, cur = setup_connection()
    cur.callproc('admin_approve_user', (username))
    con.commit()
    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}


def admin_filter_user(username, status, sort_by, sort_direction):
    con, cur = setup_connection()
    cur.callproc('admin_filter_user', (username, status, sort_by, sort_direction))
    cur.execute('SELECT * FROM AdFilterUser')
    con.commit()
    return json.dumps(cur.fetchall())

# print(admin_filter_user('', 'Approved', 'username', 'DESC'))


def admin_filter_company(com_name, min_city, max_city, min_theater, max_theater, min_employee, max_employee, sort_by,
                         sort_direction):
    con, cur = setup_connection()
    cur.callproc('admin_filter_company', (
        com_name, min_city, max_city, min_theater, max_theater, min_employee, max_employee, sort_by, sort_direction))
    cur.execute('SELECT * FROM AdFilterCom')
    con.commit()
    return json.dumps(cur.fetchall())


def admin_create_theater(theater_name, com_name, theater_street, theater_city, theater_state, theater_zip, capacity,
                         manager_username):
    con, cur = setup_connection()
    cur.callproc('admin_create_theater', (
        theater_name, com_name, theater_street, theater_city, theater_state, theater_zip, capacity, manager_username))
    con.commit()


def admin_view_com_detail_emp(company_name):
    con, cur = setup_connection()
    cur.callproc('admin_view_comDetail_emp', (company_name))
    cur.execute('SELECT * FROM AdComDetailEmp')
    con.commit()
    return json.dumps(cur.fetchall())


def admin_view_com_detail_th(company_name):
    con, cur = setup_connection()
    cur.callproc('admin_view_comDetail_th', (company_name))
    cur.execute('SELECT * FROM AdComDetailTh')
    con.commit()
    return json.dumps(cur.fetchall())


def admin_create_mov(movie_name, movie_duration, movie_release_date):
    con, cur = setup_connection()
    cur.callproc('admin_create_mov', (movie_name, movie_duration, movie_release_date))
    con.commit()
    # try:
    #     cur.callproc('admin_create_mov', (movie_name, movie_duration, movie_release_date))
    # except:
    #     return False
    # return True

def manager_filter_th(man_username, mov_name, min_mov_duration, max_mov_duration, min_mov_release_date,
                      max_mov_release_date, min_mov_play_date, max_mov_play_date, include_not_played):
    con, cur = setup_connection()
    cur.callproc('manager_filter_th', (man_username, mov_name, min_mov_duration, max_mov_duration, min_mov_release_date,
                                       max_mov_release_date, min_mov_play_date, max_mov_play_date, include_not_played))
    cur.execute('SELECT * FROM ManFilterTh')
    con.commit()
    return json.dumps(cur.fetchall())


def manager_schedule_mov(man_username, mov_name, mov_release_date, mov_play_date):
    con, cur = setup_connection()
    cur.callproc('manager_schedule_mov', (man_username, mov_name, mov_release_date, mov_play_date))
    con.commit()

def customer_filter_mov(movie_name, com_name, city, state, min_mov_play_date, max_mov_play_date):
    con, cur = setup_connection()
    cur.callproc('customer_filter_mov', (movie_name, com_name, city, state, min_mov_play_date, max_mov_play_date))
    cur.execute('SELECT * FROM CosFilterMovie')
    con.commit()
    return json.dumps(cur.fetchall())


def customer_view_mov(credit_card_num, mov_name, mov_release_date, th_name, com_name, mov_play_date):
    con, cur = setup_connection()
    cur.callproc('customer_view_mov', (credit_card_num, mov_name, mov_release_date, th_name, com_name, mov_play_date))
    con.commit()

def customer_view_history(customer_username):
    con, cur = setup_connection()
    cur.callproc('customer_view_history', (customer_username))
    cur.execute('SELECT * FROM CosViewHistory')
    con.commit()
    return json.dumps(cur.fetchall())


def user_filter_th(th_name, com_name, city, state):
    con, cur = setup_connection()
    cur.callproc('user_filter_th', (th_name, com_name, city, state))
    cur.execute('SELECT * FROM UserFilterTh')
    con.commit()
    return json.dumps(cur.fetchall())


def user_visit_th(th_name, com_name, visit_date, username):
    con, cur = setup_connection()
    cur.callproc('user_visit_th', (th_name, com_name, visit_date, username))
    con.commit()


def user_filter_visit_history(username, min_visit_date, mac_visit_date):
    con, cur = setup_connection()
    cur.callproc('user_filter_visit_history', (username, min_visit_date, mac_visit_date))
    cur.execute('SELECT * FROM UserVisitHistory')
    con.commit()
    return json.dumps(cur.fetchall())



# get_table('Movie')
# admin_create_mov('test',100,'2010-03-21')
# get_table('Movie')
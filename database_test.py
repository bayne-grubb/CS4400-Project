import pymysql
from flask import current_app, Flask
import json


def setup_connection():
    con = pymysql.connect('localhost', 'root', '', 'team13', cursorclass=pymysql.cursors.DictCursor)
    return con.cursor()

# Retrieving Data #

def get_table(table):
    cur = setup_connection()
    cur.execute('SELECT * from {}'.format(table))
    for row in cur.fetchall():
        print(row)


# get_table('User')
# get_table('Employee')


# A stored procedure
def user_login(username, password):
    cur = setup_connection()
    cur.callproc('user_login', (username, password))
    cur.execute('SELECT * FROM UserLogin')
    return json.dumps(cur.fetchall())


# print(user_login('calcultron', '333333333'))

def user_register(username, password, firstname, lastname):
    cur = setup_connection()
    cur.callproc('user_register', (username, password, firstname, lastname))
    return json.dumps({'success':True}), 200, {'ContentType':'application/json'}


def customer_only_register(username, password, firstname, lastname):
    cur = setup_connection()
    cur.callproc('customer_only_register', (username, password, firstname, lastname))
    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}


def customer_add_creditcard(username, credit_card_num):
    cur = setup_connection()
    cur.callproc('customer_add_creditcard', (username, credit_card_num))
    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}


def manager_only_register(username, password, firstname, lastname, com_name, emp_street, emp_city, emp_state, emp_zip):
    cur = setup_connection()
    cur.callproc('manager_only_register',
                 (username, password, firstname, lastname, com_name, emp_street, emp_city, emp_state, emp_zip))
    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}


def manager_customer_register(username, password, firstname, lastname, com_name, emp_street, emp_city, emp_state,
                              emp_zip):
    cur = setup_connection()
    cur.callproc('manager_customer_register',
                 (username, password, firstname, lastname, com_name, emp_street, emp_city, emp_state, emp_zip))
    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}


def admin_approve_user(username):
    cur = setup_connection()
    cur.callproc('admin_approve_user', (username))
    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}


def admin_filter_user(username, status, sort_by, sort_direction):
    cur = setup_connection()
    cur.callproc('admin_filter_user', (username, status, sort_by, sort_direction))
    cur.execute('SELECT * FROM AdFilterUser')
    return json.dumps(cur.fetchall())

# print(admin_filter_user('', 'Approved', 'username', 'DESC'))


def admin_filter_company(com_name, min_city, max_city, min_theater, max_theater, min_employee, max_employee, sort_by,
                         sort_direction):
    cur = setup_connection()
    cur.callproc('admin_filter_company', (
        com_name, min_city, max_city, min_theater, max_theater, min_employee, max_employee, sort_by, sort_direction))
    cur.execute('SELECT * FROM AdFilterCom')
    return json.dumps(cur.fetchall())


def admin_create_theater(theater_name, com_name, theater_street, theater_city, theater_state, theater_zip, capacity,
                         manager_username):
    cur = setup_connection()
    cur.callproc('admin_create_theater', (
        theater_name, com_name, theater_street, theater_city, theater_state, theater_zip, capacity, manager_username))


def admin_view_com_detail_emp(company_name):
    cur = setup_connection()
    cur.callproc('admin_view_comDetail_emp', (company_name))
    cur.execute('SELECT * FROM AdComDetailEmp')
    return json.dumps(cur.fetchall())


def admin_view_com_detail_th(company_name):
    cur = setup_connection()
    cur.callproc('admin_view_comDetail_th', (company_name))
    cur.execute('SELECT * FROM AdComDetailTh')
    return json.dumps(cur.fetchall())


def admin_create_mov(movie_name, movie_duration, movie_release_date):
    cur = setup_connection()
    cur.callproc('admin_create_mov', (movie_name, movie_duration, movie_release_date))


def manager_filter_th(man_username, mov_name, min_mov_duration, max_mov_duration, min_mov_release_date,
                      max_mov_release_date, min_mov_play_date, max_mov_play_date, include_not_played):
    cur = setup_connection()
    cur.callproc('manager_filter_th', (man_username, mov_name, min_mov_duration, max_mov_duration, min_mov_release_date,
                                       max_mov_release_date, min_mov_play_date, max_mov_play_date, include_not_played))
    cur.execute('SELECT * FROM ManFilterTh')
    return json.dumps(cur.fetchall())


def manager_schedule_mov(man_username, mov_name, mov_release_date, mov_play_date):
    cur = setup_connection()
    cur.callproc('manager_schedule_mov', (man_username, mov_name, mov_release_date, mov_play_date))


def customer_filter_mov(movie_name, com_name, city, state, min_mov_play_date, max_mov_play_date):
    cur = setup_connection()
    cur.callproc('customer_filter_mov', (movie_name, com_name, city, state, min_mov_play_date, max_mov_play_date))
    cur.execute('SELECT * FROM CosFilterMovie')
    return json.dumps(cur.fetchall())


def customer_view_mov(credit_card_num, mov_name, mov_release_date, th_name, com_name, mov_play_date):
    cur = setup_connection()
    cur.callproc('customer_view_mov', (credit_card_num, mov_name, mov_release_date, th_name, com_name, mov_play_date))


def customer_view_history(customer_username):
    cur = setup_connection()
    cur.callproc('customer_view_history', (customer_username))
    cur.execute('SELECT * FROM CosViewHistory')
    return json.dumps(cur.fetchall())


def user_filter_th(th_name, com_name, city, state):
    cur = setup_connection()
    cur.callproc('user_filter_th', (th_name, com_name, city, state))
    cur.execute('SELECT * FROM UserFilterTh')
    return json.dumps(cur.fetchall())


def user_visit_th(th_name, com_name, visit_date, username):
    cur = setup_connection()
    cur.callproc('user_visit_th', (th_name, com_name, visit_date, username))


def user_filter_visit_history(username, min_visit_date, mac_visit_date):
    cur = setup_connection()
    cur.callproc('user_filter_visit_history', (username, min_visit_date, mac_visit_date))
    cur.execute('SELECT * FROM UserVisitHistory')
    return json.dumps(cur.fetchall())




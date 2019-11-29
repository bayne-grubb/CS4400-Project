import pymysql
def setup_connection():
    con = pymysql.connect('localhost', 'root', '', 'team13')
    return con.cursor()

# Retrieving Data #

def get_table(table):
    cur = setup_connection()
    cur.execute('SELECT * from {}'.format(table))
    for row in cur.fetchall():
        print(row)

get_table('User')
get_table('Employee')

# A stored procedure
def user_login(username, password):
    cur = setup_connection()
    cur.callproc('user_login', (username, password))
    cur.execute('SELECT * FROM UserLogin')
    for row in cur.fetchall():
        print(row)

user_login('calcultron', '333333333')
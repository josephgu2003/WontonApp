from flask import Blueprint, request, jsonify, make_response
import json
from src import execute_db

waiters = Blueprint('waiters', __name__)

# Get all waiters from the DB
@waiters.route('/waiters', methods=['GET'])
def get_waiters():
    return execute_db('select * from waiters')

@waiters.route('/seat_customer/<cust_id>', methods=['POST'])
def seat_customer(cust_id):
    return execute_db('update customers set table_num = 3 where customers.cust_id = {0}'.format(cust_id))

@waiters.route('/customers_of_waiter/', methods=['GET'])
def get_customers_of_waiter():
    return execute_db('select name, table_num, payment' +
                        ' from customers ' 
                      'where active = TRUE and waiter_id = \''
                      + str(request.args.get('waiter_id')) + '\'')

# Gets the meals ready to be served to customers of this waiter
@waiters.route('/get_meals_to_serve/', methods=['GET'])
def get_meals_to_serve():
    return execute_db('select *' +
                        ' from cust_menu join customers on cust_menu.cust_id = customers.cust_id ' 
                      'where customers.active = TRUE and cust_menu.fulfilled = TRUE and cust_menu.served = FALSE and waiter_id = \''
                      + str(request.args.get('waiter_id')) + '\'')

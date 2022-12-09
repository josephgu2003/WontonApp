from flask import Blueprint, request, jsonify, make_response
import json
from src import execute_db, execute_post_request

customers = Blueprint('customers', __name__)

# Get all customers from the DB
@customers.route('/customers', methods=['GET'])
def get_customers():
    return execute_db('select * from customers')

# Get all active customers from the DB
@customers.route('/active_customers', methods=['GET'])
def get_active_customers():
    return execute_db('select * from customers where customers.active == true;')

# Get all active customers from the DB
@customers.route('/make_customer_order', methods=['POST'])
def make_customer_order():
    return execute_post_request('INSERT INTO customer_menu(cust_id, menu_name, fulfilled, served)' +
                                ' values(\'' + str(request.form.get("customer_id")) +
                                '\', \'' + str(request.form.get("order_name")) + '\', false, false)')

# add a new customer, meaning they just walked in to waiting area
@customers.route('/lobby_customer', methods=['POST'])
def lobby_customer():
    return execute_db('')

# seat a customer and assign them a waiter
@customers.route('/lobby_customer', methods=['POST'])
def seat_customer():
    return execute_db('')

# Get customer detail for customer with particular userID
@customers.route('/get_cust_orders/', methods=['GET'])
def get_customer_orders():
    return execute_db('select menu_name from customer_menu where cust_id = \'{0}\''.format(request.args.get("cust_id")))
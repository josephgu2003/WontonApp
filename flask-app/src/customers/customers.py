from flask import Blueprint, request, jsonify, make_response
import json
from src import execute_db

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
@customers.route('/customers', methods=['POST'])
def make_customer_order():
    return execute_db('INSERT INTO customer_menu ({id}, {name})'
                   .format(id = request.form.get("customer_id"), name = request.form.get("order_name")))

# Get customer detail for customer with particular userID
@customers.route('/customers/<userID>', methods=['GET'])
def get_customer(userID):
    return execute_db('select * from customers where customerNumber = {0}'.format(userID))
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


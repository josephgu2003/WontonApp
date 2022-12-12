from flask import Blueprint, request, jsonify, make_response
import json
from src import execute_db, execute_post_request

miscellaneous = Blueprint('miscellaneous', __name__)

# Get all customers from the DB
@miscellaneous.route('/miscellaneous', methods=['GET'])
def get_menu():
    return execute_db('select name, price, details from menu_item')

# Get all customers from the DB
@miscellaneous.route('/miscellaneous/menu_item_names', methods=['GET'])
def get_menu_item_names():
    return execute_db('select name as label, price as value from menu_item')

# Get recipe for some meal
@miscellaneous.route('/miscellaneous/recipes/<menu_item_name>', methods=['GET'])
def something_menu(menu_item_name):
    return execute_db('select * from ingre_menu where menu_name = \'{0}\''.format(menu_item_name))


# Get everything from menu table for cooks to see on their secondary page
@miscellaneous.route('/miscellaneous/recipes', methods=['GET'])
def whole_menu():
    return execute_db('select * from ingre_menu order by menu_name')

# Get all inventory information from ingredients table for cooks to see on Inventory page
@miscellaneous.route('/miscellaneous/inventory', methods=['GET'])
def get_entire_inventory():
    return execute_db('select * from ingredients')

# Get all customer orders which have not been fulfilled yet
@miscellaneous.route('/miscellaneous/current_orders', methods=['GET'])
def get_unfulfilled_orders():
    return execute_db('select * from customer_menu where fulfilled = FALSE')

# Updates a given order to now be fulfilled
@miscellaneous.route('/miscellaneous/update_order', methods=['POST'])
def make_customer_order():
    return execute_post_request(f'UPDATE customer_menu SET fulfilled = TRUE '
                                f' WHERE id = ' + str(request.form.get("order_id")))
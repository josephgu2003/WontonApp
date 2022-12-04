from flask import Blueprint, request, jsonify, make_response
import json
from src import db

miscellaneous = Blueprint('miscellaneous', __name__)

# Get all customers from the DB
@miscellaneous.route('/miscellaneous', methods=['GET'])
def get_menu():
    cursor = db.get_db().cursor()
    cursor.execute('select * from menu_item')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

    # Get all customers from the DB
@miscellaneous.route('/miscellaneous/menu_item_names', methods=['GET'])
def get_menu_item_names():
    cursor = db.get_db().cursor()
    cursor.execute('select name as label, price as value from menu_item')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get customer detail for customer with particular userID
@miscellaneous.route('/miscellaneous/<userID>', methods=['GET'])
def something_menu(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from customers where customerNumber = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
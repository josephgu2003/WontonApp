# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def execute_db(sql):
    cur = db.get_db().cursor()
    cur.execute(sql)
    row_headers = [x[0] for x in cur.description]
    json_data = []
    theData = cur.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'webapp'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_password.txt').readline()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'Wontons'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Import the various routes
    from src.views import views
    from src.customers.customers import customers
    from src.products.products  import products
    from src.miscellaneous.miscellaneous import miscellaneous

    # Register the routes that we just imported so they can be properly handled
    app.register_blueprint(views,       url_prefix='/classic')
    app.register_blueprint(customers,   url_prefix='/classic')
    app.register_blueprint(products,    url_prefix='/classic')
    app.register_blueprint(miscellaneous,   url_prefix='/classic')

    return app
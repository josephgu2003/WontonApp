# WontonApp

Our app that would assist customers, waiters, and cooks in a restaurant environment. Allows for customers to view the menu, make orders, track their order readiness, and see their table. Allows waiters to view the extended menu in case customers have questions, track cooked meals that need to be served, and mark tables as available and unavailable. Allows cooks to view unfinished orders and finish them, and also view the recipe table.

## How to set up Appsmith

1. Use ngrok to expose a public url from port 8001, and put this URL into the Wonton_DB datasource in Appsmith.

## How to setup server
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 







## REST service application using Ballerina

### Steps to run the service application using a docker container

Clone this git respository and cd into the folder that has the Dockerfile. Run the following commands on the command line to get the services listening on local 9090.

/    Build the docker image bu running `docker build -t my-app .`

/    Run the docker container by executing `docker run -d -p 9090:9090 my-app`

/    Check whether the container is up and running on port 9090 by executing `docker ps -a | grep my-app` 

If the service app is up and running you can test the REST service using CRUD http requests on postman.

   The base path to the api calls is `http://localhost:9090/social-media/users`

To run the frontend built using the REST service. The REST service must also be listening on port 9090 for requests. 

   Start up an http server to run the index.html file. In ython it can be done using the command `python -m http.server`.

   Paste the url `http://localhost:8000/index.html` to try out the application. 
   




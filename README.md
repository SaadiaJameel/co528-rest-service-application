## REST service application using Ballerina

### Steps to run the service application using a docker container

1. Clone this git respository and cd into the folder that has the Dockerfile. Run the following commands on the command line to get the services listening on local 9090.

    Build the docker image bu running `docker build -t my-app .`

    Run the docker container by executing `docker run -d -p 9090:9090 my-app`

    Check whether the container is up and running on port 9090 by executing `docker ps -a | grep my-app` 

2. If the service app is up and running you can test the REST service using postman using the following API calls.




# Use the official Ballerina image as the base
FROM ballerina/ballerina:2201.9.2

# Set the working directory in the container
WORKDIR /home/ballerina

# # Install Supervisor
# RUN apt-get update && apt-get install -y supervisor

# Copy the Ballerina service file into the container
COPY social_media_service.bal /home/ballerina/

# Build the Ballerina service
RUN bal build social_media_service.bal

# # Copy the supervisord config file
# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose the port that the Ballerina service will run on
EXPOSE 9090

# Run the Ballerina service
CMD ["bal", "run", "social_media_service.bal"]
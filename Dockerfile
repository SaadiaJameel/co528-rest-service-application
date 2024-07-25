# # Use an official Nginx image for serving the frontend
# FROM nginx:alpine as frontend

# # Copy the frontend files into the Nginx image
# COPY index.html /usr/share/nginx/html/
# COPY script.js /usr/share/nginx/html/

# # Use an official Ballerina image for the backend
# FROM ballerina/ballerina:latest as backend

# # Copy the Ballerina service file into the image
# COPY social_media_service.bal /home/ballerina/

# # Expose the port that the Ballerina service will run on
# EXPOSE 9090

# # Command to run the Ballerina service
# CMD ["ballerina", "run", "/home/ballerina/social_media_service.bal"]

# # Combine the frontend and backend in one image
# # FROM alpine:latest
# FROM node:20-alpine

# # Copy the Nginx configuration from the frontend stage
# COPY --from=frontend /usr/share/nginx/html/ /usr/share/nginx/html/

# # Copy the Ballerina runtime from the backend stage
# COPY --from=backend /home/ballerina /home/ballerina

# # Install Nginx in the final image
# RUN apk add --no-cache nginx

# # Copy the Ballerina service files into the final image
# COPY --from=backend /home/ballerina /home/ballerina

# # Expose the ports
# EXPOSE 8000
# EXPOSE 9090

# # Start Nginx and Ballerina services
# # CMD ["sh", "-c", "nginx && ballerina run /home/ballerina/social_media_service.bal"]
# CMD ["sh", "-c", "nginx"]
# # CMD ["sh", "-c", "bal run /home/ballerina/social_media_service.bal"]




# Use the official Ballerina image as the base
FROM ballerina/ballerina:2201.5.0

# Set the working directory in the container
WORKDIR /home/ballerina

# Copy the Ballerina service file into the container
COPY social_media_service.bal /home/ballerina/
COPY Ballerina.toml /home/ballerina/
COPY Dependencies.toml /home/ballerina/

# Build the Ballerina service
RUN bal build social_media_service.bal

# Expose the port that the Ballerina service will run on
EXPOSE 9090

# Run the Ballerina service
CMD ["bal", "run", "social_media_service.bal"]





# # Use the official Nginx image
# FROM nginx:alpine

# # Copy the frontend files into the Nginx image
# COPY index.html /usr/share/nginx/html/
# COPY script.js /usr/share/nginx/html/

# # Expose port 80 for the web server
# EXPOSE 80

# # Start Nginx
# CMD ["nginx", "-g", "daemon off;"]
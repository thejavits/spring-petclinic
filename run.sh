# Requires docker engine 17.05 
image_name="krishnademo.jfrog.io/default-docker-local/krishna-pet-clinic"
/usr/local/bin/docker pull $image_name
/usr/local/bin/docker run -d -p 8088:8088 $image_name

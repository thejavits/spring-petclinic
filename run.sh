image_name="krishnademo.jfrog.io/default-docker-local/krishna-pet-clinic"
docker pull $image_name
docker run -d -p 8088:8088 $image_name

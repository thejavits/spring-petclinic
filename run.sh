image_name="krishnademo.jfrog.io/default-docker-local/krishna-pet-clinic"
docker pull $image_name
docker run -d -p 8080:8080 $image_name

Build And Run the Docker Image

sudo dockerd
sudo docker build . -t jellyfin
sudo docker run -p 80:80 -p 8080:8080 jellyfin

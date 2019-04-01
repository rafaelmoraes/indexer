## Setup

    If something does not work, please let me know.

1 - Install [Docker](https://docs.docker.com/install/)

2 - Install [Docker compose](https://docs.docker.com/compose/install/)

3 - Start the docker daemon

```shellscript
# example using the systemd
sudo systemctl start docker
```

4 - Run on console

```shellscript
#Maybe you need to use sudo
docker-compose up -d
docker-compose exec rails bash
```

Now you should be inside the rails docker container

5 - Create the database

 ```shellscript
rails db:create db:migrate
 ```

6 - Run the rails server

 ```shellscript
rails s -b 0.0.0.0
 ```

7 - Open your browser and access http://localhost:3000, you should see the rails default page

## Test using curl

```shellscript
# Create
curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X POST -d '{"data": {"type":"webpages", "attributes":{"url":"https://www.bbc.co.uk/"}}}' http://localhost:3000/webpages

# Get all
curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X GET http://localhost:3000/webpages

# Get all headers indexed from webpage ID 1
curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X GET http://localhost:3000/webpages/1/headers

# Error
curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X POST -d '{"data": {"type":"webpages", "attributes":{"url":""}}}' http://localhost:3000/webpages
```

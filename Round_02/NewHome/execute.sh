docker pull mongo:latest

if [ ! "$(docker ps -a | grep bashaway-2k23-sunset)" ]; then
    docker run -d --name bashaway-2k23-sunset -p 27207:27017 mongo # Data will be populated into this instance once the tests are run.
fi

if [ ! "$(docker ps -a | grep bashaway-2k23-sunrise)" ]; then
    docker run -d --name bashaway-2k23-sunrise -p 27208:27017 mongo # Target instance to migrate data to.
fi


# Dump data from the source instance
mongodump --host localhost --port 27207 --out /tmp/bashaway_mongo_dump

# Restore data to the target instance
mongorestore --host localhost --port 27208 /tmp/bashaway_mongo_dump

# Cleanup: remove the dumped data files
rm -rf /tmp/bashaway_mongo_dump

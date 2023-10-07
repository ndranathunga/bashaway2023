from confluent_kafka import Consumer, KafkaError

# Kafka broker and topic information
bootstrap_servers = 'localhost:9092'
topic = 'SOS'

# Kafka consumer configuration
consumer_conf = {
    'bootstrap.servers': bootstrap_servers,
    'group.id': 'sos_consumer_group',
    'auto.offset.reset': 'earliest'  # Start consuming from the beginning of the topic
}

# Create a Kafka consumer instance
consumer = Consumer(consumer_conf)

# Subscribe to the topic
consumer.subscribe([topic])

try:
    while True:
        msg = consumer.poll(1.0)  # Poll for new messages every second

        if msg is None:
            continue
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                continue
            else:
                print('Error: %s' % msg.error())
                break
        print('Received message: %s' % msg.value())

except KeyboardInterrupt:
    pass

finally:
    consumer.close()

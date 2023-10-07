const crypto = require('crypto');
const { Kafka } = require('kafkajs');

const kafka = new Kafka({
  clientId: crypto.randomBytes(16).toString('hex'),
  brokers: ['localhost:9092'],
});

const producer = kafka.producer();

const produceMessages = async () => {
  await producer.connect();

  try {
    let messageNumber = 1;
    const interval = setInterval(async () => {
      const messageValue = `Distress Signal ${messageNumber}`;
      const messageKey = crypto.randomBytes(16).toString('hex');

      await producer.send({
        topic: 'SOS',
        messages: [
          {
            key: messageKey,
            value: messageValue,
          },
        ],
      });

      console.log(`Produced message - key: ${messageKey} - value: ${messageValue}`);

      messageNumber++;

      if (messageNumber > 10) {
        clearInterval(interval);
        await producer.disconnect();
      }
    }, 1000); // Send a message every second
  } catch (error) {
    console.error('Error producing messages:', error);
  }
};

produceMessages();

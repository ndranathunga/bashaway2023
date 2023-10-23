# mock_imap_server.py

import smtpd
import asyncore

class MockIMAPServer(smtpd.SMTPServer):
    def process_message(self, peer, mailfrom, rcpttos, data, mail_options=None, rcpt_options=None):
        print("Received mail from:", mailfrom)
        print("To:", rcpttos)
        print("Message:", data)

# Run the mock IMAP server on port 1636
server = MockIMAPServer(('localhost', 1636), None)
asyncore.loop()

# Unusual Endeavour: Local IMAP Server Setup

## Setup

1. Ensure you have Docker and Docker-compose installed on your system.
2. Build the Docker image:
   ```
   docker build -t custom-dovecot .
   ```
3. Run the Docker container:
   ```
   docker run -p 1636:143 custom-dovecot
   ```
4. Execute the send_email.sh script:
   ```
   chmod +x send_email.sh
   ./send_email.sh
   ```

You should now have a running IMAP server on port 1636. An email from "tech.baron@bashaway2k23.net" to "inventor@bashaway2k23.net" should be present in the inbox.

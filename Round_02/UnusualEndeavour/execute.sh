#!/bin/bash
docker build -t custom-dovecot .
docker run -p 1636:143 custom-dovecot &


# Use msmtp to send an email
echo -e "To: inventor@bashaway2k23.net\nFrom: tech.baron@bashaway2k23.net\nSubject: Homage to Historical Innovations\n\nTechnology knows no bounds." | msmtp --file=/app/msmtprc inventor@bashaway2k23.net &

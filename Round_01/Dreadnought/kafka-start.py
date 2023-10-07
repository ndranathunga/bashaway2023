import os
import subprocess
import shutil
import tarfile
import urllib.request

# Define Kafka version and download URL
kafka_version = "2.8.0"
download_url = f"https://downloads.apache.org/kafka/{kafka_version}/kafka_2.13-{kafka_version}.tgz"

# Directory where Kafka will be installed
kafka_install_dir = "kafka"

# Download Kafka
download_dir = "kafka_download"
os.makedirs(download_dir, exist_ok=True)
download_path = os.path.join(download_dir, f"kafka_{kafka_version}.tgz")

try:
    urllib.request.urlretrieve(download_url, download_path)

    # Extract Kafka
    with tarfile.open(download_path, "r:gz") as tar:
        tar.extractall(path=kafka_install_dir)
    shutil.move(os.path.join(kafka_install_dir, f"kafka_2.13-{kafka_version}"), kafka_install_dir)

    # Start Kafka
    kafka_cmd = os.path.join(kafka_install_dir, "bin", "kafka-server-start.sh")
    kafka_properties = os.path.join(kafka_install_dir, "config", "server.properties")
    subprocess.Popen([kafka_cmd, kafka_properties], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    print(f"Kafka {kafka_version} started successfully.")
except Exception as e:
    print(f"Failed to start Kafka: {e}")

# Note: Remember to stop Kafka gracefully when you're done with it.

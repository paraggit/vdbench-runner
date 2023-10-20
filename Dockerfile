FROM ubuntu:20.04

# Update the package manager and install necessary packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-11-jre-headless vim procps sysstat xfsprogs unzip && \
    apt-get clean

# Copy vdbench and other necessary files
COPY vdbench50407.zip /vdbench/vdbench50407.zip
COPY vdbench_runner.sh /vdbench/vdbench_runner.sh

# Delete installation files
WORKDIR /root

# Set the default shell to /bin/bash
SHELL ["/bin/bash", "-c"]

# Extract vdbench files
RUN unzip /vdbench/vdbench50407.zip -d /vdbench/

# Make vdbench executable
RUN chmod +x /vdbench/vdbench

# Set the entry point to start the vdbench runner
ENTRYPOINT ["/bin/bash", "-c", "/vdbench/vdbench_runner.sh"]

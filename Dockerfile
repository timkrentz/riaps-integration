FROM ubuntu:18.04

RUN /bin/bash -c "apt-get update; apt-get install apt-utils -y; apt-get upgrade -y"
RUN /bin/bash -c "apt-get install sudo software-properties-common net-tools lsb-release nano git -y"

# LIST OF CONCERNS
# - quotas
# - rdate (vm_utils_install) failure is being overridden
# - timesync isn't being installed at all

ADD riaps-x86runtime-docker /riaps-x86runtime

RUN /bin/bash -c "rm /etc/apt/sources.list"
RUN /bin/bash -c "touch /etc/apt/sources.list"

WORKDIR /riaps-x86runtime
RUN /bin/bash -c "./bootstrap.sh | tee /install.log"
#!/bin/bash
echo ""
echo "Welcome to Cround services :D"
echo ""
echo "set ssh key"
# Write env vars to disc for decoding
echo $CI_SSH > /tmp/CI_SSH
echo $CI_SSH_PUB > /tmp/CI_SSH_PUB
# create ssh dir (if not there)
mkdir -p ~/.ssh
# decode tmp files
base64 --decode /tmp/CI_SSH > ~/.ssh/id_rsa
base64 --decode /tmp/CI_SSH_PUB > ~/.ssh/id_rsa.pub
echo "public key"
cat ~/.ssh/id_rsa.pub
# clean up
rm  /tmp/CI_SSH
rm  /tmp/CI_SSH_PUB
# set access rights
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

echo ""
echo ""
echo "configure runner"
# generate configuration file
echo -e "concurrent = 1\n\n[[runners]]\n  name = \"$CI_NAME\"\n  url = \"$CI_URL\"\n  token = \"$CI_TOKEN\"\n  limit = 1\n  executor = \"shell\"\n" > /etc/gitlab-runner/config.toml
cat /etc/gitlab-runner/config.toml

echo ""
echo "Firing up service of GitLab CI runner"
#gitlab-ci-multi-runner start &
gitlab-ci-multi-runner run

# init log
#mkdir -p /data/services
#touch /data/services/my.log

# clean up
#watchman trigger-del /data/services service-update
#watchman watch-del-all

# action when change happened
#watchman -j <<-EOT
#["trigger", "/data/services", {
#  "name": "service-update",
#  "expression": ["match", "*.jar"],
#  "command": ["/bin/bash /deploy.sh"],
#  "stdout": ">>/my.log"
#}]
#EOT

#trap "exit" INT
#while [ ! -f /data/services/start.sh ]
#do
#  echo "Waiting for files"
#  echo "ls -la /data/services"
#  ls -la /data/services
#  gitlab-ci-multi-runner verify
#  sleep 5
#done

#/bin/bash /data/services/start.sh >> /data/services/my.log

# monitor log
#tail -f /data/services/my.log

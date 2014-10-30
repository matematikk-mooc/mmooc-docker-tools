FROM ubuntu:12.04

RUN apt-get -y update && \
  apt-get install -y postgresql-client tmux dialog

ADD menu.sh /root/menu.sh
ADD run.sh /root/run.sh

CMD  ["/root/run.sh"]

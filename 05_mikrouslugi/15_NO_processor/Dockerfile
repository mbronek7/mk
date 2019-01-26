FROM ruby:2.5.1

RUN apt-get update
RUN apt-get install curl wget net-tools mc procps sudo gcc build-essential ruby-dev less -y

RUN gem install fluentd --no-ri --no-rdoc
RUN fluentd --setup /opt/fluent
RUN fluent-gem install fluent-plugin-elasticsearch
RUN echo "fluentd -c /opt/fluent/fluent.conf &"       >> /opt/runner.sh
RUN echo "cd /opt && ruby processor.rb"               >> /opt/runner.sh
RUN echo "tail -f /dev/null"                          >> /opt/runner.sh
RUN chmod a+x /opt/runner.sh
RUN ln -sf /usr/share/zoneinfo/Poland /etc/localtime
COPY fluent.conf /opt/fluent/fluent.conf
COPY processor.rb /opt/
COPY Gemfile      /opt/

RUN bash -l -c "cd /opt && bundle install"
ENTRYPOINT /opt/runner.sh

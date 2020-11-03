FROM linuxbrew/brew

RUN brew tap aws/tap
RUN brew install awscli aws-sam-cli

EXPOSE 3000

WORKDIR /var/opt

ENTRYPOINT ["/home/linuxbrew/.linuxbrew/bin/sam"]
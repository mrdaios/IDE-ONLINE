FROM codercom/code-server:4.3.0
MAINTAINER mrdaios <mrdaios@gmail.com>

ARG UID=1000
ARG GID=1000

USER root
#RUN apt -y update && apt -y install build-essential gdb gcc wget mercurial
RUN chown $UID:$GID -R /home/coder

USER $UID:$GID
RUN HOME=/home/coder code-server \
	--user-data-dir=/home/coder/.local/share/code-server \
    --install-extension vscjava.vscode-java-pack \
    --install-extension vscjava.vscode-spring-initializr \
    --install-extension redhat.vscode-xml \
    --install-extension redhat.fabric8-analytics \
    --install-extension ms-ceintl.vscode-language-pack-zh-hans

RUN curl -O https://repo.huaweicloud.com/java/jdk/11.0.2+9/jdk-11.0.2_linux-x64_bin.tar.gz

ADD jdk-11.0.2_linux-x64_bin.tar.gz /user/local/java

# ADD extensions /home/coder/.local/share/code-server/extensions

# # ENV
ENV JAVA_HOME /user/local/java/jdk-11.0.2

ENTRYPOINT ["/usr/bin/entrypoint.sh", "--auth", "none", "--bind-addr", "0.0.0.0:8080", "."]
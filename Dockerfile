FROM scratch

LABEL maintainer="alexschomb"

# copy local files
COPY root/ /

# install templates
RUN chmod +x /install-templates.sh
CMD /install-templates.sh

# volumes
VOLUME /templates
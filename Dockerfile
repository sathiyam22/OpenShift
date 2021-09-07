FROM dpage/pgadmin4 as pgadmin4

# Create pgadmin user
HOME=/pgadmin
RUN mkdir -p ${HOME} && \
mkdir -p ${HOME}/pgadmin && \
useradd -u 1001 -r -g 0 -G pgadmin -d ${HOME} -s /bin/bash \
-c "Default Application User" pgadmin

# Set user home and permissions with group 0 and writeable.
RUN chmod -R 700 ${HOME} && chown -R 1001:0 ${HOME}

# Create the log folder and set permissions
RUN mkdir /var/log/pgadmin && \
chmod 0600 /var/log/pgadmin && \
chown 1001:0 /var/log/pgadmin

# Run as 1001 (pgadmin)
USER 1001

VOLUME /var/lib/pgadmin
EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]

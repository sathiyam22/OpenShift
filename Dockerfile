FROM dpage/pgadmin4 as pgadmin4

USER root 
RUN chown -R 1000720000:1000720000 /pgadmin4 && \
    chown -R 1000720000:1000720000 /var && \
    chown -R 1000720000:1000720000 /var/lib/pgadmin && \
    chmod -R 0777 /pgadmin4 && \
    chmod -R 0777 /var/lib/pgadmin && \
    mkdir -p /var/lib/pgadmin/sessions && \
    chmod -R 0777 /var/lib/pgadmin/sessions && \ 
    sed 's@python /run_pgadmin.py@python /pgadmin4/run_pgadmin.py@g' /entrypoint.sh
    chmod -R 0777 /var/lib/pgadmin && \

USER 1000720000

VOLUME /var/lib/pgadmin
EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]

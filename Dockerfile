FROM dpage/pgadmin4 as pgadmin4

USER root 
RUN chown -R 1000720000:1000720000 /pgadmin4 && \
    chown -R 1000720000:1000720000 /var && \
    chown -R 1000720000:1000720000 /var/lib/pgadmin && \
    sed 's@python /run_pgadmin.py@python /pgadmin4/run_pgadmin.py@g' /entrypoint.sh

USER 1000720000

VOLUME /var/lib/pgadmin
EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]

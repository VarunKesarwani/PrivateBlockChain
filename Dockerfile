FROM ethereum/client-go:v1.10.1

ARG ACCOUNT_PASSWORD

COPY blockpoa.json /tmp

RUN geth init /tmp/blockpoa.json \
    && rm -f ~/.ethereum/geth/nodekey \
    && echo ${ACCOUNT_PASSWORD} > /tmp/password \
    && geth account new --password /tmp/password \
    && rm -f /tmp/password

# RUN geth init /tmp/blockpoa.json \
#     && rm -f ~/.ethereum/geth/nodekey \
#     && echo ${ACCOUNT_PASSWORD} > /tmp/password \
#     && geth account new --password /tmp/password \
#     && rm -f /tmp/password

ENTRYPOINT ["geth"]
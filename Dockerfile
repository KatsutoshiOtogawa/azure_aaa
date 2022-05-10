ARG VARIANT="1.18"
FROM golang:${VARIANT}-bullseye as builder

RUN useradd -m app
WORKDIR /home/app
COPY . .

RUN chown -R app /home/app
USER app
RUN go mod tidy
RUN go build -o out/server

FROM debian:bullseye-slim

COPY --from=builder /home/app/out/server /usr/local/bin/

RUN apt update && apt upgrade -y

RUN apt install -y libcap2-bin

RUN chmod 755 /usr/local/bin/server

RUN setcap 'cap_net_bind_service=+ep' /usr/local/bin/server
RUN useradd -m app
# app用のsocket
RUN mkdir /var/run/go && chown app /var/run/go

USER app
WORKDIR /home/app

CMD ["/usr/local/bin/server"]

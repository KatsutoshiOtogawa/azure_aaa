FROM golang:1.18-bullseye as builder

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
RUN chmod 755 /usr/local/bin/server

EXPOSE 80
RUN useradd -m app
USER app
WORKDIR /home/app

CMD ["/usr/local/bin/server"]

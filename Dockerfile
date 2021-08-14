FROM golang:alpine as builder
# add build dependencies
RUN apk add --update gcc musl-dev upx make
# build the binary
RUN mkdir /app 
ADD . /app/
WORKDIR /app 
RUN make build
# compress the binary
RUN upx -9 -k mnemonicK5

FROM alpine:latest
COPY --from=builder /app/mnemonicK5 /app/
WORKDIR /app 
CMD [ "/app/mnemonicK5" ]
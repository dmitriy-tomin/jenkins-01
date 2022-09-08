FROM golang:1.16 AS builder

# Copy the code from the host and compile it
WORKDIR $GOPATH/src/github.com/dmitriy-tomin/jenkins-01
COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -buildvcs=false -installsuffix nocgo -o /app .

FROM alpine:latest
RUN apk -U add ca-certificates
COPY --from=builder /app /app
CMD ["/app"]

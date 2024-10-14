FROM golang:1.21-alpine

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN ls -la

RUN GOOS=linux GOARCH=amd64 go build -o silly-demo

RUN chmod +x silly-demo

RUN go install github.com/cespare/reflex@latest

EXPOSE 8080

CMD ["reflex", "-c", "echo './silly-demo' | reflex -r '\\.go$' -- sh -c './silly-demo'"]

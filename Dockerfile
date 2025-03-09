FROM golang:1.22.5 AS base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o /main .

#FINAL STAGE -- DISTROLESS STAGE
FROM gcr.io/distroless/base

COPY --from=base /main /main
COPY --from=base /app/static ./static
EXPOSE 8080

CMD ["/main"]




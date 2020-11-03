#!/bin/bash
# get delve and compile
go get -u github.com/go-delve/delve/cmd/dlv
GOARCH=amd64 GOOS=linux go build -o ./dlv github.com/go-delve/delve/cmd/dlv
# get aws-lambda code
go get -u github.com/aws/aws-lambda-go/...
# Build binary with debug symbols
buildDev() {
    local lambda=$1
    echo "Building ${lambda} ..."
    # build binary
    GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -gcflags="all=-N -l" -o .aws-sam/build/${lambda}/${lambda} lambda/${lambda}/main.go
}
# list lambdaas
lambdas=($(ls lambda))
# Build all lambdas in parallel
for i in ${lambdas[@]}; do buildDev "$i" & done
# Wait for builds to finish
wait
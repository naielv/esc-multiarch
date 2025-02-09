
all: deps clean build

build: esc-amd64 esc-arm esc-arm64

esc-amd64: 
	CGO_ENABLED=1 GOOS=linux GOARCH=amd64 go build -a -tags netgo -o esc-amd64 cmd/esc/main.go

esc-arm: 
	CC=arm-linux-gnueabi-gcc CGO_ENABLED=1 GOOS=linux GOARCH=arm GOARM=6 go build -a -tags netgo -o esc-arm cmd/esc/main.go

esc-arm64: 
	CC=aarch64-linux-gnu-gcc CGO_ENABLED=1 GOOS=linux GOARCH=arm64 go build -a -tags netgo -o esc-arm64 cmd/esc/main.go

docker: docker-amd64 docker-arm

docker-amd64: esc-amd64
	docker build -t diogok/esc .

docker-arm: esc-arm
	docker build -t diogok/esc:arm -f Dockerfile.arm .

clean:
	rm -f esc-*

deps:
	go get github.com/ghodss/yaml
	go get github.com/micro/mdns
	go get github.com/diogok/gorpc
	go get github.com/patrickmn/go-cache
	go get github.com/yuin/gopher-lua
	go get layeh.com/gopher-json
	go get github.com/cjoudrey/gluahttp

push:
	docker push diogok/esc

run:
	go run -race cmd/esc/main.go

install:
	go install cmd/esc/main.go

create:
	protoc --proto_path=protocol-buffers --go_out=./pb protocol-buffers/cosmos/**/**/tx.proto
	protoc --proto_path=protocol-buffers --go_out=./pb protocol-buffers/nodamatics/*.proto
	protoc --proto_path=protocol-buffers --go-grpc_out=./pb protocol-buffers/nodamatics/*.proto
	protoc --proto_path=protocol-buffers --openapiv2_out ./openapi protocol-buffers/nodamatics/*.proto
	protoc --proto_path=protocol-buffers \
	--grpc-gateway_out ./pb \
    --grpc-gateway_opt logtostderr=true \
    --grpc-gateway_opt generate_unbound_methods=true \
    protocol-buffers/nodamatics/*.proto

build:
	GOOS=windows GOARCH=amd64 go build -o bin/main-amd64.exe main.go
	GOOS=linux GOARCH=amd64 go build -o bin/main-amd64 main.go

clean:
	rm ./pb/*.go
	rm ./openapi/**/*
	rm ./bin/*
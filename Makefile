create:
	protoc --proto_path=protocol-buffers --go_out=./pb protocol-buffers/cosmos/**/**/tx.proto
	protoc --proto_path=protocol-buffers --go_out=./pb protocol-buffers/nodamatics/shared.proto
	protoc --proto_path=protocol-buffers --go_out=./pb protocol-buffers/nodamatics/public/islamic.proto
	protoc --proto_path=protocol-buffers --go-grpc_out=./pb protocol-buffers/nodamatics/public/islamic.proto
	protoc --proto_path=protocol-buffers --openapiv2_out ./openapi \
	--openapiv2_opt grpc_api_configuration=protocol-buffers/nodamatics/grpc-gateway/islamic.config.yaml \
 	protocol-buffers/nodamatics/public/islamic.proto
	protoc --proto_path=protocol-buffers \
	--grpc-gateway_out ./pb \
    --grpc-gateway_opt logtostderr=true \
    --grpc-gateway_opt grpc_api_configuration=protocol-buffers/nodamatics/grpc-gateway/islamic.config.yaml \
    --grpc-gateway_opt generate_unbound_methods=true \
    protocol-buffers/nodamatics/public/islamic.proto

build:
	GOOS=windows GOARCH=amd64 go build -o bin/main-amd64.exe main.go
	GOOS=linux GOARCH=amd64 go build -o bin/main-amd64 main.go

clean:
	rm ./pb/*.go
	rm ./openapi/nodamatics/public/*
	rm ./bin/*
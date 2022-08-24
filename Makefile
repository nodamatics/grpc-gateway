create:
	protoc --proto_path=proto --go_out=./pb proto/nodamatics/*.proto
	protoc --proto_path=proto --go-grpc_out=./pb proto/nodamatics/*.proto
	protoc --proto_path=proto --openapiv2_out ./openapi proto/nodamatics/*.proto
	protoc --proto_path=proto \
	--grpc-gateway_out ./pb \
    --grpc-gateway_opt logtostderr=true \
    --grpc-gateway_opt generate_unbound_methods=true \
    proto/nodamatics/*.proto

build:
	GOOS=windows GOARCH=amd64 go build -o bin/main-amd64.exe main.go
	GOOS=linux GOARCH=amd64 go build -o bin/main-amd64 main.go

clean:
	rm ./openapi/**/*
	rm ./bin/*
	rm ./pb/*.go
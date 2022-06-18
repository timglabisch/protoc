build_container:
	docker build -t timglabisch/protogen .

run:
	rm -rf out
	# rust
	mkdir -p out/rust
	docker run \
		--rm \
		--entrypoint=/protogen \
		-e "PROTOC=/usr/local/bin/protoc" \
		-v "`pwd`/proto:/proto" \
		-v "`pwd`/out/rust:/proto_out" \
		timglabisch/protogen

	# php
	mkdir -p out/php
	docker run \
		--rm \
		--entrypoint=protoc \
		-v "`pwd`/proto:/proto" \
		-v "`pwd`/out/php:/proto_out" \
		timglabisch/protogen \
		--experimental_allow_proto3_optional \
		--proto_path=/proto \
		--php_out=/proto_out \
		--grpc_out=/proto_out \
		--plugin=protoc-gen-grpc=/usr/local/bin/grpc_php_plugin \
		/proto/items.proto

	# ruby
	mkdir -p out/ruby
	docker run \
		--rm \
		--entrypoint=protoc \
		-v "`pwd`/proto:/proto" \
		-v "`pwd`/out/ruby:/proto_out" \
		timglabisch/protogen \
		--experimental_allow_proto3_optional \
		--proto_path=/proto \
		--ruby_out=/proto_out \
		/proto/items.proto


	# typescript
	mkdir -p out/typescript
	docker run \
		--rm \
		--entrypoint=protoc \
		-v "`pwd`/proto:/proto" \
		-v "`pwd`/out/typescript:/proto_out" \
		timglabisch/protogen \
		--experimental_allow_proto3_optional \
		--proto_path=/proto \
		--plugin=/ts_proto/node_modules/.bin/protoc-gen-ts_proto \
		--ts_proto_out=/proto_out \
		/proto/items.proto


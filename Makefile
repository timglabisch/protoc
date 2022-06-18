build_container:
	docker build -t timglabisch/protogen .

run:
	docker run \
		--rm \
		--entrypoint=/protogen \
		-v "`pwd`/proto:/proto" \
		-v "`pwd`/out:/proto_out" \
		timglabisch/protogen
IMAGE_NAME ?= pcavezzan/ftpsdev
IMAGE_TAG ?= latest
IMAGE_VERSION ?= v1.0.0
CONTAINER_IMAGE := $(IMAGE_NAME):$(IMAGE_TAG)

build:
	docker image build -t $(CONTAINER_IMAGE) .
	docker image tag $(CONTAINER_IMAGE) $(IMAGE_NAME):$(IMAGE_VERSION)

run: build
	docker container run --rm --name ftpsdev -p 21:21 -p 50000-50009:50000-50009 $(CONTAINER_IMAGE)
#!/bin/bash

# Criando um container com o terraform
docker container run -it \
    --name terraform \
    -v "$(pwd)":/mnt/curso-terraform \
    -- entrypoint /bin/sh \
    hashicorp/terraform
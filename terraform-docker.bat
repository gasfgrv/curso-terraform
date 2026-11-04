@echo off

REM Criando um container com o Terraform

docker container run -it ^
    --name terraform ^
    -v "%cd%":/mnt/curso-terraform ^
    --entrypoint /bin/sh ^
    hashicorp/terraform
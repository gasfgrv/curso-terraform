# Terraform

# Introdução

## Introdução ao terraform

**O que é?**

- É a principal ferramente de IaC da atualidade;
- Se popularizou junto com o aumento de provedores de *cloud* publica e com a necessidade de criar recursos de maneira rápida, eficiente e replicável
- Usa uma linguagem própria (HCL), mas também funciona com JSON
- Trabalha de maneira declarativa, em que os recurso são definidos em código e a ferramenta se encarrega de fazer o restante
- Possui uma grande quantidade de providers oficiais
- A comunidade provisiona uma vasta oferta de módulos
    - Módulos: são como pacotes de recursos prontos para serem utilizados
- Vantagens:
    - Simplicidade da linguagem HCL
    - Multicloud
    - Cria recursos de maneira declarativa]
    - Documentação clara e bem estruturada
    - Pode ser usado com outras ferramentas de IaC
    - Idempotente
    - Rápido, eficiente, replicável e livre de erros humanos

> **Como usar o terraform via imagem docker**
> 
> - Iniciar um container: `docker container run -it --name terraform -v $(pwd):/mnt/curso-terraform --entrypoint /bin/sh hashicorp/terraform`
> - Remover o container que foi criado anteriormente: `docker container stop terraform && docker container rm terraform`
> - Iniciar um container configurando para que seja automaticamente removido quando sair dele: `docker container run -it --rm --name terraform -v $(pwd):/mnt/curso-terraform --entrypoint /bin/sh hashicorp/terraform`

# Funções básicas

## Estrutura de arquivos

- Arquivos suportados tem a extensão `.tf`
- Dentro de um diretório pode haver mais de um arquivo, em que todos eles farão parte do mesmo código
    - Uma boa prática é colocar o códigos em arquivos distintos, para facilitar a manutenção
- Os arquivos `.tfvars` serve para definir os valores das variáveis declaradas
- O arquivo `.tfstate` é criado automaticamente pelo terraform, e serve para salvar o estado atual das alterações feitas, e o arquivo `.tfstate.backup` é um backup da versão anterior
- O arquivo `.terraform.lock.hcl` serve para controle das dependências do terraform
    - Semelhante ao node.js que possui um arquivo com as versões das libs e demais configurações
- O diretório `.terraform` salva as configurações de módulos remotos e providers instalados no código
    - Semelhante à *.node_modules*

## Estrutura de blocos da linguagem HCL

Tipos de blocos:

- **Terraform:** Este é o bloco raiz em um arquivo de configuração do Terraform. Ele define a versão do Terraform que está sendo usada e pode incluir configurações globais, como backend e provedores padrão.
- **Providers:** Este bloco é usado para configurar provedores de infraestrutura, como AWS, Azure, Google Cloud, etc. Aqui você especifica detalhes de autenticação e configuração para se conectar a esses provedores.
- **Resource:** Este bloco é usado para definir recursos de infraestrutura que você deseja criar e gerenciar. Cada recurso tem um tipo (por exemplo, aws_instance, aws_s3_bucket) e atributos específicos desse tipo de recurso.
- **Data:** Este bloco é usado para consultar e usar dados existentes, como informações sobre recursos de infraestrutura já criados. Isso é útil para obter informações sobre recursos que foram criados fora do Terraform.
- **Module:** Este bloco é usado para encapsular partes reutilizáveis de configuração em módulos. Os módulos permitem modularizar sua configuração, tornando-a mais fácil de manter e reutilizar em vários projetos.
- **Output:** Este bloco é usado para declarar valores que serão mostrados após a execução do Terraform. Isso pode incluir informações úteis, como IDs de recursos criados ou endpoints de serviços.
- **Locals:** Este bloco é usado para declarar valores locais (variáveis locais) que podem ser reutilizados em várias partes do arquivo de configuração do Terraform. Isso é útil para evitar repetição de código.

```hcl
terraform {
#   possui as configurações gerais do terraform
}

provider "nome_provider" {
#   possui as configurações do provider 
}

resource "tipo_recurso" "identificador_recurso" {
#   possui as configurações para a criação de recursos dentro do provider 
}

data "fonte_dos_dados" "identificador" {
#   serve para pegar os dados de fora do terraform para dentro do código
}

module "nome_modulo" {
#   serve para a criação de módulos dentro do terraform
source = "pode ser local ou remoto"
}

variable "nome_variavel" {
#   serve para a definição de variáveis dentro do terraform
}

output "nome" {
#   expõe as informações geradas durante a execução do terraform
value = ""
}

locals {
#    é usado para armazenar códigos que são usados com muita frequência durante o código 
}
```

## Configuração do bloco ‘terraform’

```hcl
terraform {
  required_version = "~> 1.8.0"

  required_providers {
    aws = {
      version = "~> 5.0.0"
      source  = "hashicorp/aws"
    }

    azurerm = {
      version = "~> 5.0.0"
      source  = "hashicorp/azurerm"
    }
  }

  backend "local" {
    workspace_dir = "/home"
  }

}
```

## Comandos do terraform

### `init`

Inicializa um diretório de trabalho com todas as dependências e configurações. Deve ser o primeiro comandos a ser rodado após escrever um código terraform ou clonar do controle de versões.

[Command: init | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/init)

### `providers`

Apresenta as informações relacionadas ao provider de cloud.

[Command: providers | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/providers)

### `fmt`

É usado para reescrever o código de maneira canônica ao estilo do HCL ou JSON.

[Command: fmt | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/fmt)

### `validate`

Varre todo o código em busca de erros nele.

[Command: validate | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/validate)

### `plan`

Gera um plano de execução, mostrando as ações que o Terraform pretende realizar com base nas alterações no código de infraestrutura. Ele não executa as ações, apenas mostra o que será feito. Isso é útil para entender o impacto das mudanças antes de aplicá-las.

[Command: plan | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/plan)

### `show`

Exibe informações sobre o estado atual da infraestrutura gerenciada pelo Terraform. Isso inclui informações sobre recursos provisionados, como suas configurações e metadados associados.

[Command: show | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/show)

### `apply`

Executa o plano de execução gerado pelo **`terraform plan`**. Ele aplica as mudanças definidas no código de infraestrutura, provisionando, atualizando ou removendo recursos conforme necessário para fazer com que a infraestrutura corresponda à definição no código.

[Command: apply | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/apply)

### `destroy`

Usado para destruir toda a infraestrutura gerenciada pelo Terraform. Ele remove todos os recursos provisionados de acordo com a definição no código. É importante usar com cuidado, pois pode resultar na perda de dados e serviços se aplicado inadvertidamente.

[Command: destroy | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/destroy)

# Variáveis e Outputs

## Variáveis

Permite customizar aspectos do código sem precisar alterar o código fonte, permitindo compartilhar os valores através de diversas configurações, ajudando na reutilização do código.
Os valores das variáveis podem ser definidos a partir da CLI, arquivos `.tf` e variáveis de ambiente.

### Declarando variáveis

```hcl
variable "nome_da_variavel" {
  type = string
}
```

O nome da variável deve ser único no módulo, pois é usado para fazer o *bind* do valor vindo de uma fonte externa com a variável.
Os identificadores a seguir não são permitidos para nomear as variáveis, por serem palavras chaves da linguagem HCL:

- `source`
- `version`
- `providers`
- `count`
- `for_each`
- `lifecycle`
- `depends_on`
- `locals`

### Argumentos do bloco `variable`

- `default`: Define um valor padrão caso, não seja definido um valor.
- `type`: Tipo de dados da variável
- `description`: Descrição do para que serve a variável
- `validation`: Validação do valor da variável, além da definição de uma mensagem de erro.
- `sensitive`: Informa ao terraform não apresentar o valor da variável na etapa de `plan` e também nos `outputs`
- `nullable`: Define se a variável pode ser nula ou não.

### Constraint `type`

Serve para restringir o tipo de valor que será aceito pela variável, caso não seja definido no bloco da variável, ela aceitará qualquer tipo de valor.
Recomenda-se o uso, pois serve para ajudar quem for utilizar o código criado, além de permitir que o terraform alerte em caso de uso errado.
A constraint pemite os seguintes tipos:

- `string`
- `number`
- `bool`
- `list(type)`
- `set(type)`
- `map(type)`
- `object({attr_name = type})`
- `tuple([type])`

### Validação customizada

```hcl
variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \\"ami-\\"."
  }
}
```

### Usando as variáveis

```hcl
resource "aws_instance" "example" {
  instance_type = "t2.micro"
  ami           = var.image_id
}

```

### Atribuindo valores às variáveis

Existem várias formas de como declarar os valores, sendo elas:

- Via linha de comando:
    - `terraform apply -var='image_id_list=["ami-abc123","ami-def456"]' -var="instance_type=t2.micro"`
- Via arquivos `.tfvars`:
    - `terraform apply -var-file="testing.tfvars"`
- Via variáveis de ambiente:
    - `export TF_VAR_image_id=ami-abc123 && terraform plan`

### Ordem de precedência na definição de variáveis

1. Variáveis de ambiente
2. Arquivo `terraform.tfvars`
3. Arquivos `terraform.tfvars.json`
4. Arquivos `.auto.tfvars` ou `.auto.tfvars.json`
5. `var` e `var-file`

## Referencias a nomes

- Resources: `<RESOURCE TYPE>.<NAME>`
- Input variables: `var.<NAME>`
- Local values: `local.<NAME>`
- Outputs de módulos filhos: `module.<MODULE NAME>.<OUTPUT NAME>`
- Data sources: `data.<DATA TYPE>.<NAME>`

## **Valores Locais**

Permitem atribuir nomes a expressões dentro de um módulo, facilitando reutilização. Útil para evitar repetição, mas deve ser usado com moderação para manter a legibilidade da configuração.

A declaração é feita em um bloco `locals`, podendo combinar variáveis, atributos de recursos e outros valores locais.

Para usar, bastar referenciar com o `local.<NOME>`, acessíveis apenas dentro do módulo onde foram declarados.

## Outputs

Disponibilizam e expõem informações sobre a infraestrutura para que outras configurações possam fazer proveito delas.
Seus usos consistem em:

- Um módulo filho pode usar saídas para expor um subconjunto de seus atributos de recursos para um módulo pai.
- Um módulo raiz pode usar saídas para imprimir determinados valores na saída CLI depois executando `terraform apply`.

### Declarando um output

```hcl
saída "instance_ip_addr" {
  valor = aws_instance.server.private_ip
}
```

O bloco `precondition` serve para especificar garantias sobre dados de saída.

```hcl
output "api_base_url" {
  value = "<https://$>{aws_instance.example.private_dns}:8433/"

  # The EC2 instance must have an encrypted root volume.
  precondition {
    condition     = data.aws_ebs_volume.example.encrypted
    error_message = "The server's root volume is not encrypted."
  }
}
```

### Argumentos opcionais

- `description`: Serve para documentar a função da saída
- `sensitive`: Serve para ocultar dados sensíveis ao executar `terraform plan` e `terraform apply`.
- `depends_on`: define uma dependência explicita adicional para que em casos em que as dependências que não podem ser reconhecidas implicitamente pelo terraform.

# Terraform State

No Terraform, o *state* é um arquivo que armazena informações sobre a infraestrutura gerenciada por ele. Ele mantém o rastreamento do mapeamento entre os recursos definidos no código e os recursos reais no provedor de nuvem. Isso permite que o Terraform determine o que precisa ser criado, alterado ou destruído em uma aplicação subsequente. O *state* também é crucial para operações como o *plan* e o *apply*, pois fornece uma visão da infraestrutura atual.

[State | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/state)

## Backend

O *backend* no Terraform é o mecanismo que define onde e como o *state* é armazenado. Além do armazenamento, o *backend* também é responsável por operar o *lock* (bloqueio) do *state*, garantindo que apenas uma operação de *terraform apply* ocorra por vez, evitando conflitos. Existem vários tipos de backends, como o local, que armazena o *state* no disco, e remotos, como o S3 da AWS, o Azure Blob Storage, ou o Google Cloud Storage.

[Backend Configuration - Configuration Language | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/settings/backends/configuration)

## Local State

O *local state* refere-se ao *state* que é armazenado localmente no disco do usuário que está executando o Terraform. Este é o tipo de *state* padrão quando não há um *backend* remoto configurado. Embora simples de configurar, o *local state* pode ser problemático em ambientes de equipe, pois pode levar a conflitos e inconsistências se várias pessoas estiverem manipulando a mesma infraestrutura.

## Remote State

O *remote state data source* é um recurso do Terraform que permite consultar o *state* remoto de outro workspace ou de outro projeto. Isso é útil para compartilhar informações entre diferentes partes da infraestrutura gerenciada por Terraform, permitindo que um conjunto de configurações acesse os resultados de outros conjuntos. Por exemplo, o endereço IP de um load balancer criado em um módulo pode ser usado em outro módulo consultando o *remote state* correspondente.

[The terraform_remote_state Data Source | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/state/remote-state-data)

## Comandos

### terraform show

O comando `terraform show` é utilizado para exibir informações detalhadas sobre o estado atual da infraestrutura gerenciada pelo Terraform. Ele mostra uma visão completa dos recursos provisionados, incluindo seus atributos e configurações, como estão armazenados no arquivo de estado. Esse comando pode ser útil para verificar as configurações atuais dos recursos e garantir que estão de acordo com o esperado. Ele pode gerar a saída em formato legível para humanos ou em formato JSON, o que é útil para automação e integração com outras ferramentas.

[Command: show | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/show)

### terraform state

O comando `terraform state` fornece várias sub-funcionalidades para manipular diretamente o arquivo de estado do Terraform, que é um arquivo onde o Terraform armazena informações sobre a infraestrutura gerenciada. As operações mais comuns incluem:

- `terraform state list`: Lista todos os recursos que estão sendo gerenciados pelo Terraform.
- `terraform state show`: Mostra detalhes sobre um recurso específico gerenciado pelo Terraform.
- `terraform state mv`: Move um recurso de uma parte do estado para outra, o que pode ser útil para renomear recursos.
- `terraform state rm`: Remove recursos do estado, sem destruí-los na infraestrutura real, o que pode ser necessário em casos de gerenciamento manual ou limpeza do estado.

[Command: state | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/state)

### terraform import

O comando `terraform import` é utilizado para trazer recursos que já existem em uma infraestrutura para dentro da gestão do Terraform. Quando você tem recursos que foram criados manualmente ou através de outro sistema, esse comando permite que você os associe ao estado do Terraform sem precisar recriá-los. Com isso, o Terraform passa a ter conhecimento desses recursos, permitindo que você gerencie e aplique futuras alterações neles de maneira controlada.

[Command: import | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/import)

### terraform init

- **reconfigure:** Esse comando é utilizado para reconfigurar o backend do Terraform. Ele força o Terraform a ignorar qualquer configuração de backend já existente e a buscar a configuração atual definida nos arquivos de configuração. É útil quando há mudanças na configuração do backend e você deseja garantir que o Terraform utilize a configuração mais recente.
- **migrate-state:** Esse comando é usado para migrar o estado do Terraform de um backend para outro. Quando você muda o backend do Terraform, o estado (que contém informações sobre a infraestrutura gerenciada) precisa ser movido para o novo backend. Esse parâmetro ajuda a automatizar essa migração, garantindo que o estado seja transferido de forma segura e consistente.
- **backend-config:** Esse comando permite especificar configurações adicionais para o backend durante a inicialização do Terraform. Por exemplo, você pode passar parâmetros de configuração do backend diretamente na linha de comando ou especificar um arquivo que contenha essas configurações. Isso é útil para personalizar a configuração do backend de forma dinâmica ou em diferentes ambientes.

[Command: init | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/init)

### terraform force-unlock

O comando `terraform force-unlock` é utilizado para liberar manualmente o estado bloqueado de um workspace do Terraform. Esse bloqueio ocorre quando o Terraform executa operações, como `apply` ou `plan`, para garantir que nenhuma outra operação simultânea possa modificar o estado, evitando conflitos.

No entanto, em casos de falha durante a operação, o bloqueio pode persistir, impedindo novas execuções. O comando `terraform force-unlock` remove esse bloqueio manualmente, utilizando o ID do bloqueio, permitindo que o Terraform possa retomar as operações. É importante usar esse comando com cautela, pois a remoção imprudente de um bloqueio pode levar a inconsistências no estado.

[Command: force-unlock | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/force-unlock)

# Provisioners

Provisioners no Terraform são usados para executar scripts ou comandos em instâncias ou recursos após eles terem sido criados. Eles são úteis para realizar tarefas de configuração ou para integração de automação após a criação do recurso, como instalação de software, modificação de configurações, ou execução de comandos que não são possíveis diretamente via Terraform.

[Provisioners | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

## Provisioner Connection

A `Provisioner Connection` define como o Terraform se conecta a um recurso para executar os provisioners. Ela especifica informações de conexão, como o tipo de conexão (por exemplo, SSH para servidores Linux ou WinRM para Windows), endereço IP, credenciais, e outras opções necessárias para estabelecer a conexão com o recurso alvo. Sem uma configuração correta da `Provisioner Connection`, o Terraform não conseguirá executar os provisioners.

[Provisioner Connection Settings | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/resources/provisioners/connection)

## File Provisioner

O `File Provisioner` é um tipo de provisioner no Terraform usado para copiar arquivos ou diretórios do sistema local (de onde o Terraform está sendo executado) para a instância remota ou recurso que foi criado. Ele é útil para transferir scripts, configurações, ou qualquer outro arquivo necessário para a configuração do recurso.

[Provisioner: file | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/resources/provisioners/file)

## local-exec Provisioner

O `local-exec Provisioner` é usado para executar comandos localmente na máquina onde o Terraform está sendo executado, em vez de no recurso remoto criado. Ele é útil para tarefas que precisam ser realizadas na máquina de controle após o recurso ser criado, como chamar comandos externos, scripts, ou integrar com outras ferramentas locais.

[Provisioner: file | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/resources/provisioners/file)

## remote-exec Provisioner

O `remote-exec Provisioner` permite que comandos sejam executados diretamente na instância remota ou recurso criado, através da conexão estabelecida. Ele é ideal para tarefas como a instalação de pacotes, execução de scripts, ou outras operações de configuração diretamente na máquina criada pelo Terraform.
Esses provisioners são poderosos, mas devem ser usados com cuidado, pois podem introduzir complexidade e problemas de consistência se não forem gerenciados corretamente.

[Provisioner: remote-exec | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)

## terraform_data

No Terraform, o bloco `data` é utilizado para obter informações ou dados sobre recursos já existentes, seja em sua infraestrutura, em um provedor de nuvem ou em qualquer outra fonte externa. Esses dados são normalmente usados para referenciar recursos que não são criados diretamente pelo Terraform, mas que ainda são necessários para a configuração. Por exemplo, você pode usar um bloco `data` para obter informações sobre uma VPC, um grupo de segurança, ou até mesmo uma imagem AMI na AWS. A principal função do bloco `data` é permitir que você utilize esses recursos existentes como parte de suas configurações Terraform, sem precisar recriá-los.

[The terraform_data Managed Resource Type | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

### Por que os `provisioners` devem ser usados como último recurso

Os `provisioners` no Terraform são utilizados para executar comandos ou scripts na máquina virtual ou infraestrutura após a criação do recurso. Embora possam ser úteis, o uso de `provisioners` deve ser considerado como último recurso porque eles quebram a filosofia do Terraform de "infraestrutura como código", tornando a configuração menos previsível, menos idempotente e mais difícil de gerenciar.

- **Imprevisibilidade:** Provisioners podem introduzir comportamentos não determinísticos, já que dependem de operações fora do controle direto do Terraform, como scripts e comandos que podem falhar por diversos motivos (erros de rede, permissões, etc.).
- **Idempotência:** O Terraform é projetado para ser idempotente, ou seja, aplicar múltiplas vezes o mesmo código deve resultar no mesmo estado de infraestrutura. Os provisioners, no entanto, podem executar comandos que não são idempotentes, causando inconsistências.
- **Manutenção Difícil:** Provisioners podem complicar o código, tornando-o mais difícil de manter e depurar. Se algo der errado durante a execução de um provisioner, o estado da infraestrutura pode ficar inconsistente, e o Terraform pode não conseguir gerenciar ou reverter a mudança adequadamente.

Portanto, é recomendado usar `provisioners` somente quando não houver outra alternativa viável para realizar uma configuração ou tarefa específica. O ideal é buscar soluções alternativas que se integrem melhor com a abordagem declarativa do Terraform, como o uso de módulos, scripts de inicialização (`cloud-init`) ou ferramentas de gerenciamento de configuração (Ansible, Chef, Puppet).

# **Terraform Modules**

Um **módulo** no Terraform é um grupo de recursos que são configurados juntos para serem reutilizados em diferentes partes da sua infraestrutura. Em outras palavras, é um bloco de construção que contém configurações de infraestrutura, como a definição de instâncias de máquinas virtuais, redes, regras de segurança, entre outros. Os módulos permitem que você agrupe esses recursos em um único componente reutilizável, facilitando o gerenciamento de infraestruturas complexas.

[Modules Overview - Configuration Language | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/modules)

## Módulos locais

**Módulos locais** são módulos que estão presentes no mesmo repositório ou no mesmo diretório do seu código principal do Terraform. Eles são utilizados quando você deseja organizar seu código em diferentes diretórios dentro do seu projeto. Isso facilita a manutenção do código e permite a reutilização de partes dele em diferentes configurações sem a necessidade de duplicação. Para utilizar um módulo local, basta referenciá-lo pelo caminho relativo do diretório onde ele está localizado.

## Módulos remotos

**Módulos remotos** são módulos que estão armazenados fora do repositório local, como em repositórios Git, no Terraform Registry (repositório oficial de módulos Terraform) ou em outros locais acessíveis via URL. A principal vantagem dos módulos remotos é a possibilidade de reutilização de configurações compartilhadas por diferentes equipes ou projetos, mantendo uma única fonte de verdade para a configuração de infraestrutura. Para utilizar um módulo remoto, você especifica o endereço do repositório ou do local onde o módulo está hospedado.

## `terraform get`

O comando `terraform get` é utilizado para baixar e atualizar os módulos definidos no seu código Terraform. Quando você adiciona um novo módulo ou altera a fonte de um módulo (seja local ou remoto), é necessário executar `terraform get` para que o Terraform faça o download ou a atualização dos módulos referenciados. Isso garante que o Terraform tenha todas as dependências necessárias para a execução dos planos de infraestrutura.

[Command: get | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cli/commands/get)

# Meta Arguments

Terraform Meta Arguments são parâmetros especiais utilizados para configurar e controlar o comportamento dos blocos de recursos, módulos, ou outros elementos em uma configuração do Terraform. Eles não afetam diretamente a criação dos recursos, mas influenciam como e quando esses recursos são gerados, modificados, ou destruídos. Alguns dos Meta Arguments mais comuns em Terraform são `depends_on`, `count`, `for_each`, `provider`, e `lifecycle`.

## `depends_on`

O argumento `depends_on` é utilizado para criar dependências explícitas entre recursos no Terraform. Normalmente, o Terraform é capaz de determinar automaticamente as dependências entre recursos, mas em alguns casos, é necessário especificar manualmente que um recurso depende da criação ou atualização de outro. Isso garante que o Terraform respeite a ordem correta ao criar, atualizar ou destruir os recursos.
Exemplo:

```hcl
resource "aws_instance" "web" {
  # configurações do recurso
}

resource "aws_eip" "web_ip" {
  instance = aws_instance.web.id

  depends_on = [aws_instance.web]
}
```

No exemplo acima, `aws_eip.web_ip` depende explicitamente da criação do recurso `aws_instance.web`.

## `count`

O argumento `count` é utilizado para criar múltiplas instâncias de um recurso com base em um número específico. Ele permite que você defina quantas vezes um recurso deve ser criado, facilitando a criação em massa sem a necessidade de duplicar código.

Exemplo:

```hcl
resource "aws_instance" "web" {
  count = 3

  # configurações do recurso
}
```

Neste exemplo, três instâncias do recurso `aws_instance.web` serão criadas.

## `for_each`

O argumento `for_each` é similar ao `count`, mas permite a criação de múltiplas instâncias de um recurso com base em uma coleção (lista ou mapa) de itens. Cada item na coleção gera uma instância do recurso, e a chave ou valor do item pode ser usado para personalizar as configurações de cada instância.

Exemplo:

```hcl
resource "aws_instance" "web" {
  for_each = {
    server1 = "ami-123456"
    server2 = "ami-654321"
  }

  ami           = each.value
  instance_type = "t2.micro"
}
```

Neste caso, duas instâncias do recurso `aws_instance.web` serão criadas, cada uma com uma AMI diferente.

## `provider`

O argumento `provider` especifica qual provedor deve ser utilizado para um recurso específico. Isso é útil em casos onde múltiplos provedores do mesmo tipo são configurados (por exemplo, múltiplas contas da AWS), e você precisa garantir que um recurso utilize um provedor específico.

Exemplo:

```hcl
provider "aws" {
  alias  = "us_east"
  region = "us-east-1"
}

resource "aws_instance" "web" {
  provider = aws.us_east

  # configurações do recurso
}
```

Aqui, o recurso `aws_instance.web` será criado na região `us-east-1` utilizando o provedor `aws.us_east`.

## `lifecycle`

O argumento `lifecycle` é utilizado para controlar o ciclo de vida dos recursos no Terraform, definindo como eles devem ser tratados durante operações de criação, atualização ou destruição. Ele possui sub-argumentos como `create_before_destroy`, `prevent_destroy` e `ignore_changes`.

- `create_before_destroy`: Garante que um novo recurso seja criado antes de o antigo ser destruído.
- `prevent_destroy`: Impede que o recurso seja destruído.
- `ignore_changes`: Ignora mudanças em atributos específicos, evitando que o Terraform faça atualizações desnecessárias.

Exemplo:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
  }
}
```

Nesse exemplo, o recurso `aws_instance.web` será protegido contra destruição e, se houver uma substituição, o novo recurso será criado antes que o antigo seja destruído.

Esses Meta Arguments fornecem um alto grau de controle sobre como os recursos são gerenciados no Terraform, permitindo uma configuração mais flexível e robusta.

# **Terraform Functions & Expressions**

## Conditional Expressions

As *Conditional Expressions* no Terraform permitem que você escolha um valor com base em uma condição booleana (verdadeira ou falsa). Elas funcionam de maneira semelhante a um operador ternário em linguagens de programação tradicionais, como `condição ? valor_se_verdadeiro : valor_se_falso`. No Terraform, a sintaxe é a seguinte:

```hcl
condição ? valor_se_verdadeiro : valor_se_falso
```

Por exemplo, você pode usar uma expressão condicional para definir o tipo de instância de uma máquina virtual com base no ambiente:

```hcl
instance_type = var.environment == "production" ? "t3.large" : "t3.micro"
```

Aqui, se a variável `environment` for igual a "production", o tipo de instância será `t3.large`; caso contrário, será `t3.micro`.

## For Expressions

As *For Expressions* no Terraform são usadas para gerar listas ou mapas a partir de outra lista ou mapa. Elas permitem iterar sobre uma coleção e aplicar uma transformação a cada item. A sintaxe básica para listas é:

```hcl
[for item in lista : transformação]
```

E para mapas:

```hcl
{for chave, valor in mapa : chave => transformação}
```

Por exemplo, para criar uma lista de nomes de instâncias de uma lista de identificadores:

```hcl
instance_names = [for id in var.instance_ids : "instance-${id}"]
```

## Splat Expressions

As *Splat Expressions* são uma maneira conveniente de acessar atributos de todos os elementos de uma lista de recursos ou outras estruturas complexas. Elas são especialmente úteis quando você quer extrair um único atributo de todos os recursos em um bloco. A sintaxe é:

```hcl
resource_list[*].attribute
```

Por exemplo, se você tiver um conjunto de instâncias do EC2 e quiser obter todos os endereços IP públicos:

```hcl
public_ips = aws_instance.example[*].public_ip
```

Aqui, `[*]` significa "para cada instância em `aws_instance.example`, extraia o `public_ip`".

## Dynamic Blocks

Os *Dynamic Blocks* são usados no Terraform para gerar blocos de configuração repetitivos dinamicamente. Eles são úteis quando a quantidade de blocos aninhados ou a própria existência de um bloco depende de uma condição ou de um número variável. A sintaxe envolve o uso da palavra-chave `dynamic`:

```hcl
dynamic "nome_do_bloco" {
  for_each = var.lista_ou_mapa
  content {
    # configuração do bloco
  }
}
```

Por exemplo, para criar várias regras de segurança em um grupo de segurança do AWS:

```hcl
dynamic "ingress" {
  for_each = var.ingress_rules
  content {
    from_port   = ingress.value.from_port
    to_port     = ingress.value.to_port
    protocol    = ingress.value.protocol
    cidr_blocks = ingress.value.cidr_blocks
  }
}
```

## Terraform console

O *Terraform Console* é uma ferramenta interativa que permite executar expressões e explorar os valores de variáveis, recursos, e funções do Terraform em tempo real. Ele é particularmente útil para depuração e para entender como certas expressões se comportam. Você pode iniciar o console com o comando:

```hcl
terraform console
```

Dentro do console, você pode experimentar diferentes expressões, como:

```sh
> var.my_variable
> aws_instance.example.public_ip
> length(var.list_of_items)
```

## Built-in Functions

O Terraform oferece uma ampla gama de *Built-in Functions* que ajudam a manipular dados e realizar operações dentro das configurações. Essas funções incluem manipulação de strings, cálculos matemáticos, transformações de listas e mapas, e muito mais. Por exemplo:

- `length(list)`: Retorna o número de elementos em uma lista.
- `upper(string)`: Converte uma string para letras maiúsculas.
- `merge(map1, map2)`: Combina dois mapas em um só.
- `join(separator, list)`: Junta os elementos de uma lista em uma única string, separada por um delimitador.

Exemplo de uso de uma função embutida:

```hcl
joined_string = join(", ", ["apple", "banana", "cherry"]) # "apple, banana, cherry"
```

Esses conceitos são fundamentais para utilizar o Terraform de maneira mais eficiente e flexível, permitindo a criação de configurações mais complexas e dinâmicas.

## Terraform workspaces

O Terraform Workspace é uma funcionalidade do Terraform que permite a criação de ambientes isolados dentro de um mesmo diretório de configuração. Isso significa que, ao invés de ter que criar pastas separadas para gerenciar diferentes ambientes (como "dev", "staging" e "prod"), você pode utilizar Workspaces para manter essas configurações separadas dentro de um mesmo repositório.

Cada Workspace tem seu próprio conjunto de estados (`state files`), o que permite que você aplique a mesma configuração de infraestrutura em diferentes ambientes sem que um afete o outro. Isso facilita a reutilização do código e o gerenciamento centralizado de diferentes ambientes.

## Terraform data source

O **Terraform Data Source** é um recurso que permite que você consulte informações de recursos externos ou pré-existentes sem a necessidade de gerenciá-los diretamente com o Terraform. Isso é útil quando você precisa referenciar recursos já existentes na sua infraestrutura, como VPCs, subnets, AMIs, ou qualquer outro recurso que já esteja provisionado.

Com Data Sources, o Terraform lê esses dados e permite que você os utilize dentro da sua configuração, sem criar ou modificar os recursos. Esses dados são usados somente para leitura.

## Target e Replace Resources

### Comando `target`

O comando `-target` é usado para focar a execução do Terraform em um recurso ou módulo específico. Isso é útil quando você quer aplicar ou destruir apenas uma parte da infraestrutura sem afetar o restante, ou quando você está fazendo depurações ou testes incrementais. Ele limita a operação (como `apply` ou `destroy`) a um recurso ou módulo específico em um plano de execução.

```hcl
terraform apply -target=aws_instance.example
```

Neste exemplo, o Terraform vai aplicar (criar, modificar ou destruir) apenas o recurso `aws_instance.example`. Se outros recursos existirem no estado ou na configuração, eles não serão tocados.

### Quando usar o `target`:

1. **Depuração e desenvolvimento**: Quando você quer testar mudanças em um recurso específico sem aplicar a todo o projeto.
2. **Alterações seletivas**: Se você está lidando com um grande ambiente e quer aplicar mudanças gradualmente, o `target` permite isolar partes da infraestrutura.
3. **Destruição seletiva**: Também pode ser usado para destruir um recurso específico sem afetar o resto do ambiente.

### Comando `replace`

O comando `-replace` força o Terraform a destruir e recriar um recurso, mesmo que ele não tenha detectado nenhuma mudança em seu estado ou configuração. Isso é útil quando você quer substituir um recurso por completo, por exemplo, se algum recurso está em um estado inconsistente e não está sendo atualizado corretamente.

Você pode usá-lo da seguinte forma:

```hcl
terraform apply -replace=aws_instance.my_instance
```

Nesse caso, o Terraform destruirá o recurso `aws_instance.my_instance` e criará um novo. Isso é especialmente útil para resolver problemas em que o estado de um recurso não reflete mais a realidade ou quando há necessidade de um novo provisionamento completo, como no caso de migração para um novo IP, por exemplo.

### Quando usar:

- Para corrigir problemas em um recurso que não podem ser solucionados por atualizações parciais.
- Quando se deseja recriar um recurso de maneira forçada, como substituir uma instância em um autoscaling group.

## Time Sleep

O recurso `time_sleep` do Terraform, disponível no provedor `time`, é utilizado para inserir atrasos arbitrários em um plano ou aplicação de infraestrutura. Isso pode ser útil em cenários onde é necessário garantir que ações dependentes ocorram após um intervalo específico de tempo.

### Como funciona o `time_sleep`

O recurso cria um atraso intencional durante a execução do Terraform, pausando por um tempo definido antes de prosseguir com as próximas operações. Este atraso pode ser configurado em segundos ou como uma duração no formato `time.Duration`, um padrão comum em linguagens como Go.

### Configuração do `time_sleep`

A sintaxe básica para configurar um recurso `time_sleep` é a seguinte:

```hcl
resource "time_sleep" "example" {
	create_duration = "30s"
}
```

Neste exemplo, o Terraform pausa por 30 segundos durante a fase de aplicação (`apply`) antes de prosseguir para o próximo recurso ou operação.

### Campos principais

- **`create_duration`**: Especifica a duração do atraso no formato `time.Duration`. Este é o único campo obrigatório.
    - Exemplos:
        - `"10s"` para um atraso de 10 segundos.
        - `"1m30s"` para um atraso de 1 minuto e 30 segundos.

### Exemplo de uso prático

Um caso comum de uso do `time_sleep` é quando se trabalha com sistemas que requerem um período de tempo para estabilização ou replicação antes de iniciar ações subsequentes. Por exemplo:

```hcl
resource "time_sleep" "wait_for_stabilization" {
  create_duration = "2m"
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}

resource "null_resource" "after_stabilization" {
  depends_on = [time_sleep.wait_for_stabilization]

  provisioner "local-exec" {
    command = "echo 'Aguardou 2 minutos antes de executar'"
  }
}
```

Nesse exemplo:

1. Uma instância EC2 é criada.
2. O Terraform aguarda 2 minutos antes de executar qualquer ação que dependa do recurso `time_sleep`.
3. Após esse período, um comando local é executado.

### Considerações

- O `time_sleep` não deve ser utilizado como substituto de mecanismos de espera mais sofisticados, como os fornecidos por recursos nativos de provedores. Por exemplo, muitos provedores oferecem parâmetros ou recursos de espera para verificar o estado de um recurso antes de prosseguir.
- É importante usar o `time_sleep` apenas quando necessário, pois atrasos arbitrários podem aumentar significativamente o tempo de execução dos planos Terraform.

## terraform_data e null_resources

O Terraform oferece diversas maneiras de gerenciar dependências e comportamentos em recursos, incluindo o uso de recursos dinâmicos e a reexecução baseada em alterações. Entre essas ferramentas estão os recursos `null_resource`, `terraform_data` e a propriedade `lifecycle` com a configuração `replace_triggered_by`. Aqui está uma explicação sobre como esses elementos funcionam e podem ser usados em conjunto.

### **Recursos `terraform_data`**

O bloco `terraform_data` permite que dados do plano de execução sejam utilizados diretamente como dependências ou para influenciar outros recursos. Embora seja mais simples e estático do que os recursos tradicionais, ele é útil para representar informações que não precisam ser mantidas após a aplicação do plano.
Por exemplo, você pode usar `terraform_data` para calcular ou derivar valores que servem como insumos para outros recursos:

```hcl
terraform_data "example" "example_data" {
  value = {
    config = "some_value"
  }
}
```

A vantagem do `terraform_data` é sua integração simplificada com o fluxo declarativo do Terraform, permitindo que dependências entre recursos sejam estabelecidas de maneira transparente.

### **Recursos `null_resource`**

O recurso `null_resource` é um recurso genérico que não gerencia nenhum tipo de infraestrutura, mas pode executar provisionadores ou ser usado como marcador para dependências e gatilhos. É útil em cenários onde você precisa forçar execuções baseadas em mudanças específicas.

Por exemplo:

```hcl
resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo 'Executando algo...'"
  }

  triggers = {
    key = var.some_value
  }
}
```

Aqui:

- A propriedade `triggers` força a recriação do recurso quando o valor de `var.some_value` muda.
- Os provisionadores atrelados ao `null_resource` são reexecutados quando necessário.

### **Propriedade `lifecycle.replace_triggered_by`**

O atributo `lifecycle` do Terraform permite configurar o comportamento de recursos. Uma de suas funcionalidades avançadas é o uso de `replace_triggered_by`, que força a substituição de um recurso quando determinados outros elementos mudam.
Por exemplo:

```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  lifecycle {
    replace_triggered_by = [null_resource.example]
  }
}

resource "null_resource" "example" {
  triggers = {
    rebuild = var.rebuild_trigger
  }
}
```

Neste exemplo:

1. Quando `var.rebuild_trigger` muda, o `null_resource` é recriado.
2. A propriedade `replace_triggered_by` no recurso `aws_instance` faz com que a instância EC2 seja substituída se o `null_resource` for recriado.
Isso cria uma dependência explícita, mesmo que não haja vínculo direto entre os dois recursos.

### **Exemplo prático combinando `null_resource`, `terraform_data` e `replace_triggered_by`**

Imagine que você precise de um comportamento que dependa de alterações em variáveis de configuração, mas sem um vínculo direto entre os recursos. O exemplo abaixo ilustra o uso combinado desses recursos:

```hcl
terraform_data "config" "dynamic_data" {
  value = {
    parameter = var.some_parameter
  }
}

resource "null_resource" "trigger" {
  triggers = {
    config_change = terraform_data.config.dynamic_data.value["parameter"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  lifecycle {
    replace_triggered_by = [null_resource.trigger]
  }
}
```

- O `terraform_data` armazena dados derivados da variável `some_parameter`.
- O `null_resource` observa mudanças no valor armazenado e é recriado quando necessário.
- A propriedade `replace_triggered_by` força a substituição da instância EC2 sempre que o `null_resource` é recriado.

### **Considerações importantes**

- **Eficiência**: Evite usar `null_resource` para dependências quando o provedor do recurso suporta verificações ou dependências nativas.
- **Debugging**: Recursos como `null_resource` e `replace_triggered_by` podem complicar a visualização de dependências, então documente bem seu uso no código.
- **Alternativas**: Sempre prefira recursos e métodos nativos ao provedor antes de recorrer ao `null_resource` ou `terraform_data`.
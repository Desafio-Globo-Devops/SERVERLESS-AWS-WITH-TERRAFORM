# Estrutura Serverless
## Requisitos para rodar a aplicação:

- Estar com o AWS CLI instalado e configurado com a account fullacess desejada;
- Ter o Terraform 12 instalado;

### ![](https://i.imgur.com/iFNeSho.png)

Como mostrado acima, esse será o fluxo e estrutura da infra com o propósito de adicionar Logs de uma conta AWS especificada pelo usuário a um Banco de dados. Como variáveis de ambiente deverão ser setadas a ```ACCOUNT ID``` e ```Region```.
A apliicação subirá um serviço Cloudtrail referente a ```ACCOUNT ID``` setada e criará os logs para a mesma num Bucket do serviço S3. Seguindo esse fluxo também subirá uma ```TABLE``` no DynamoDB chamada *Event_Capture* no qual um lambda feito na linguagem *Python* e fará o trabalho de importar os Logs do S3 para o DynamoDB.

### Executando a aplicação:
Existe um makefile no projeto para facilitar os comandos, então caso queira fazer um plano de execução, basta usar o comando ```make plan``` e será dado o init das pendencias e o planejamento do projeto sobre toda a estrutura. Caso queira ir GO WILD, basta usar o comando ```make apply``` no terminal do projeto e toda estrutura subirá. Para destruir toda a aplicação, utilize o comando ```make destroy``` e todos os serviços serão removidos da account AWS.

### Ferramentas

 - Linguagem: **Python 3.7**
 - Infraestrutura: **Terraform 12**
 - Banco de dados: **DynamoDB**

autor: **Daniel Nicácio**

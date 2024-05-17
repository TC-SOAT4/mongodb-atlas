## Tech Challenge - FASE 4

### Criação de cluster Mongo utilizando Terraform

Projeto para criar um cluster Mongo utilizando Terraform.

------------

**Requisitos para executar**

- Conta AWS
- Conta Terraform Cloud
- AWS CLI
- Terraform CLI
- Kubectl CLI

- AWS:
    - Criar/Gerar credenciais de acesso AWS no IAM:
        - AWS_ACCESS_KEY_ID
        - AWS_SECRET_ACCESS_KEY
        


- Terraform Cloud:
    - Criar um **organization** e substituir no  arquivo **terraform.tf**
    - Criar **Variable sets** e adicionar as credenciais de acesso AWS :
        - Criar uma entrada para: AWS_ACCESS_KEY_ID
        - Criar uma entrada para: AWS_SECRET_ACCESS_KEY

- Terraform CLI: Executar comando abaxio para realizar login e gerar o token de acesso para o Terraform.

- Configuracão IAM access entries: No **aws_eks_access_entry** substituir no **principal_arn** pelo usuario configurado no AWS CLI para conseguir acessar o cluster via **kubectl**. Essa configuração pode ser feita no Console da AWS dentro do cluster na aba de **Access**.

- Apos a criação do cluster, com o **IAM access entries** configurado, acessar a abas **Access**, selecionar o usuário no **IAM access entries** é adicionar as seguintes polices no **Access policies**:
    - AmazonEKSAdminPolicy
    - AmazonEKSClusterAdminPolicy	
    - AmazonEKSEditPolicy	
    - AmazonEKSViewPolicy


```
$ terraform login
```
------------

**Executar**

- Inicializar
```
$ terraform init
```
- Aplicar mudanças
```
$ terraform apply
```
- Configurar **kubectl** com cluster criado 
```
$ aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```

- Limpar/Deletar
```
$ terraform destroy
```

------------

**Configurações adicionais após criação do cluster**

Para visualizar os recursos e Pods é necessario realizar uma configuração no auth AWS no ConfigMap do cluster.

No contexto do cluster criado, executar o seguinate comando: 
```
kubectl edit configmap aws-auth -n kube-system
```
 Adicionar a seguinate linha abaixo(mesma indentação) do **mapRoles**
 ```
 mapUsers: "- groups: \n  - system:masters\n  userarn: arn:aws:iam::<aws-account-id>:root\n"
 ```
 Substituir o **<aws-account-id>** pelo o id da credencial configurada no AWS CLI.
 Para visualizar o **aws-account-id** executar o seguinte comando:
```
 aws sts get-caller-identity
```
 








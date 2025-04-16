#!/bin/bash

# Excluir diretórios, grupos e usuários existentes (se existirem)
# O comando || true garante que o script continue mesmo se o item não existir

# Diretórios
rm -rf /publico /adm /ven /sec || true

# Grupos
groupdel GRP_ADM || true
groupdel GRP_VEN || true
groupdel GRP_SEC || true

# Usuários
userdel -r carlos || true
userdel -r maria || true
userdel -r joao_ || true
userdel -r debora || true
userdel -r sebastiana || true
userdel -r roberto || true
userdel -r josefina || true
userdel -r amanda || true
userdel -r rogerio || true


# Criar diretórios
mkdir /publico /adm /ven /sec

# Definir o usuário root como dono dos diretórios
chown root:root /publico /adm /ven /sec [cite: 13]

# Criar grupos
groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

# Criar usuários e adicionar aos grupos
useradd -m -g GRP_ADM carlos
useradd -m -g GRP_ADM maria

useradd -m -g GRP_VEN joao_
useradd -m -g GRP_VEN debora
useradd -m -g GRP_VEN sebastiana
useradd -m -g GRP_VEN roberto

useradd -m -g GRP_SEC josefina
useradd -m -g GRP_SEC amanda
useradd -m -g GRP_SEC rogerio

# Permissão total no diretório público para todos
chmod 777 /publico [cite: 14]

# Permissões dos diretórios de departamento
chmod 770 /adm /ven /sec
chgrp GRP_ADM /adm
chgrp GRP_VEN /ven
chgrp GRP_SEC /sec [cite: 15, 16]


echo "Estrutura de diretórios, grupos e usuários criada com sucesso!"
echo "Lembre-se de configurar as senhas dos usuários."

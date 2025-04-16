#!/bin/bash

# Definições de variáveis para melhor organização
DIRETORIOS=("publico" "adm" "ven" "sec")
GRUPOS=("GRP_ADM" "GRP_VEN" "GRP_SEC")
SENHA_PADRAO="Senha123"

USUARIOS_ADM=("carlos" "maria" "joao")
USUARIOS_VEN=("debora" "sebastiana" "roberto")
USUARIOS_SEC=("josefina" "amanda" "rogerio")

# Função para criar diretórios
criar_diretorios() {
  echo "Criando diretórios..."
  for dir in "${DIRETORIOS[@]}"; do
    mkdir -p "/${dir}"
    if [ $? -eq 0 ]; then
      echo "Diretório '/${dir}' criado com sucesso."
    else
      echo "Erro ao criar o diretório '/${dir}'."
    fi
  done
  echo ""
}

# Função para criar grupos
criar_grupos() {
  echo "Criando grupos de usuários..."
  for grupo in "${GRUPOS[@]}"; do
    groupadd "$grupo" 2>/dev/null # Ignora erro se o grupo já existir
    if [ $? -eq 0 ]; then
      echo "Grupo '$grupo' criado com sucesso."
    else
      echo "Grupo '$grupo' já existe ou ocorreu um erro."
    fi
  done
  echo ""
}

# Função para criar usuários para um determinado grupo
criar_usuarios_grupo() {
  local grupo="$1"
  local usuarios=("${@:2}") # Pega todos os argumentos a partir do segundo

  echo "Criando usuários para o grupo '$grupo'..."
  for user in "${usuarios[@]}"; do
    useradd -m -s /bin/bash -p "$(openssl passwd -crypt "$SENHA_PADRAO")" -G "$grupo" "$user" 2>/dev/null
    if [ $? -eq 0 ]; then
      echo "Usuário '$user' criado e adicionado ao grupo '$grupo'."
    else
      echo "Erro ao criar o usuário '$user'."
    fi
  done
  echo ""
}

# Função para definir permissões de diretórios
definir_permissoes() {
  echo "Especificando permissões dos diretórios...."
  chown root:GRP_ADM /adm
  chmod 770 /adm
  chown root:GRP_VEN /ven
  chmod 770 /ven
  chown root:GRP_SEC /sec
  chmod 770 /sec
  chown root:root /publico # Explicitamente definindo o grupo para /publico
  chmod 777 /publico
  echo ""
}

# Execução das funções
criar_diretorios
criar_grupos
criar_usuarios_grupo GRP_ADM "${USUARIOS_ADM[@]}"
criar_usuarios_grupo GRP_VEN "${USUARIOS_VEN[@]}"
criar_usuarios_grupo GRP_SEC "${USUARIOS_SEC[@]}"
definir_permissoes

echo "Fim....."

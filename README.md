# projeto-estagio

## Instalando WSL
1. Abra o painel de controle na aba de programas;
2. Certifique-se de ativar "Subsistema do Windows para Linux" dentro da opção "Ativar ou desativar recursos do Windows";
3. Reinicie o computador como instruido pelo menu do passo anterior.


4. Execute o Windows PowerShell, que pode ser encontrado no menu iniciar do Windows, como administrador;
5. Execute o comando:  ```wsl --install```  para instalar a distribuição padrão (Ubuntu 24.04.1 LTS no momento de escrita dessa documentação);
6. Reinicie novamente o computador;

7. execute o ubuntu, que já deve ter aparecido no menu iniciar, e aguarde a instalação;
8. Por fim, insira um nome de usuario e senha para o sistema Linux (não precisando ser equivalente ao usuario windows);

## Instalando Nginx
* Atualizar o sistema em preparo para a instalação.
1. ```apt update```
2. ```apt upgrade -y```
* Instalar o Nginx
3. ```apt install nginx```
* Apenas isso é o suficiente para validar o script, já que por padrão o nginx hospeda uma pagina de boas-vindas.

### Monitoramento de Servidor Nginx
check-nginx.sh permite verificar se um servidor Nginx está em execução em um determinado endereço e porta, com a flexibilidade de configurar diversos parâmetros de execução diretamente pela linha de comando. Caso o servidor esteja ativo, o script registra a informação em um arquivo de log específico. Caso contrário, registra que o servidor não foi encontrado em outro log específico.
#### Funcionalidade

- Verifica se o servidor Nginx está acessível no URL e porta especificados, usando ```curl```.
- Registra no arquivo found.log caso o servidor Nginx esteja ativo.
- Registra no arquivo notFound.log caso o servidor Nginx não esteja ativo.
- A data e hora da verificação são incluídas em cada entrada de log.

#### Como Usar

Este script aceita os seguintes parâmetros de linha de comando:

    -u URL
        O endereço do servidor a ser verificado (padrão: http://localhost).

    -p PORTA
        A porta do servidor a ser verificada (padrão: 80).

    -d DIRETORIO_DE_LOGS
        O diretório onde os logs serão armazenados (padrão: ~/nginx-project-logs).

    -t TIMEOUT
        O tempo limite para a conexão, em segundos (padrão: 10).

    -h
        Exibe a ajuda com informações sobre como usar o script.

Linha usada do Crontab para automatização:

```*/5 * * * * /caminho/para/seu/script/verifica_nginx.sh```

Assim os logs, com parâmetros padrôes, são gerados a cada 5 minutos.

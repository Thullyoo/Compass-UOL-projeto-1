# 📡 Monitoramento de Servidor Nginx com Notificação no Telegram

**Projeto desenvolvido para o Compass UOL**  
Script de monitoramento que verifica a disponibilidade do Nginx a cada minuto e envia alertas via Telegram em caso de falha.

---

### 1. Instalação do Ambiente Linux 🛠

Para este projeto utilizamos:
- **Distribuição**: Ubuntu 24.04 LTS
- **Virtualização**: Oracle VirtualBox 7.0
- **Configuração mínima recomendada**:
  - 2 vCPUs
  - 2GB RAM
  - 20GB de armazenamento (dinâmico)

**Passos de instalação**:
1. Baixe a ISO oficial do Ubuntu 24.04
2. Crie uma nova VM no VirtualBox
3. Execute a instalação padrão
4. Após instalação, atualize os pacotes:
```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Configuração do Servidor Webinx 🖥️

Execute os seguintes comandos para instalar o servidor web:
```bash
sudo apt-get install nginx -y
```

Verifique se o servidor está executando:
```
service nginx status
```

Caso após a instalação o servidor não tenha iniciado utilize: 
```bash
service nginx start
```

Sinta-se a vontade para trocar a página que será exibida pelo nginx, basta excluir o arquivo padrão .html do nginx e por outro no lugar, o diretório para trocar é o seguinte:

```
cd /var/www/html
```

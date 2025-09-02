# DNSparser - PowerShell

Ferramenta em **PowerShell** para coletar links de um site, resolver os domínios para seus endereços IPv4 e salvar os resultados em um arquivo `.txt`.  

---

## Funcionalidades

- Solicita ao usuário o site a ser analisado.
- Descobre o tipo de servidor web que roda o site.
- Coleta todos os links absolutos (`http` ou `https`) presentes na página.
- Resolve os domínios dos links para seus respectivos endereços IPv4.
- Salva os resultados em um arquivo chamado `<site>.txt`.
- Permite realizar múltiplas pesquisas em sequência.

---

## Requisitos

- PowerShell 5.1 ou superior.
- Conexão com a internet.
- Permissão para executar scripts PowerShell no sistema (`Set-ExecutionPolicy` pode ser necessário).

---

## Como usar

1. Abra o **PowerShell**.
2. Navegue até a pasta onde o script DNSparser está salvo.
3. Execute o script:

```powershell
.\DNSparser.ps1

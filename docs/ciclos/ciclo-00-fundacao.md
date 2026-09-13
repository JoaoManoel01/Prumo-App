# Ciclo 00 — Fundação
Fase: 1
Data de abertura: a preencher

## Objetivo
Estabelecer a estrutura de camadas, as entidades de domínio e a persistência local do Prumo, sem nenhuma interface.

## Escopo incluso

1. Estrutura de pastas em `app/lib/`: `dominio/` (entidades e interfaces de repositório, sem dependência de framework), `dados/` (implementação Drift), `aplicacao/` (providers Riverpod), `apresentacao/` (vazia nesta rodada).
2. Entidades de domínio, imutáveis, com igualdade por valor:
   - **Cliente** — id, nome, telefone, email, endereco, bairro, cidade, observacoes, criadoEm, atualizadoEm, estadoSincronizacao
   - **ItemCatalogo** — id, descricao, tipo (`maoDeObra` | `peca`), unidade, precoPadraoCentavos, categoria, ativo, criadoEm, atualizadoEm, estadoSincronizacao
   - **Documento** — id, clienteId, tipo (`orcamento` | `ordemServico` | `recibo`), numero, status (`rascunho` | `enviado` | `aprovado` | `recusado`), dataEmissao, validadeDias, descontoCentavos, observacoes, criadoEm, atualizadoEm, estadoSincronizacao
   - **ItemDocumento** — id, documentoId, itemCatalogoId (opcional), descricao, tipo, quantidade, precoUnitarioCentavos, ordem, criadoEm, atualizadoEm
3. Todo identificador é UUID v4 gerado no cliente. Todo valor monetário é `int` em centavos. Toda data é armazenada em UTC.
4. Interfaces de repositório em `dominio/`, uma por agregado, com operações de criar, atualizar, remover, buscar por id e listar.
5. Implementação Drift dessas interfaces, com esquema, migração inicial versionada e mapeamento entre tabela e entidade.
6. Providers Riverpod expondo os repositórios, com a implementação local registrada.
7. Testes de repositório contra banco em memória.
8. Portão configurado e verde.

## Escopo excluído

Qualquer tela, widget, rota ou tema. Cálculo de total, subtotal ou desconto — é ciclo 2. Geração de PDF. Câmera, foto, assinatura. Qualquer chamada de rede, cliente HTTP ou modelo de API. Seed de dados de exemplo. Internacionalização.

## Pré-requisitos

`bootstrap.md` concluído: árvore criada, projeto Flutter compilando, portão rodando.

## Critérios de aceite

1. `flutter analyze` retorna zero avisos em modo estrito
2. Nenhum arquivo em `dominio/` importa Flutter, Drift ou qualquer pacote de infraestrutura
3. Criar, ler, atualizar e remover funciona para os quatro agregados, com persistência real
4. Reabrir o banco recupera os dados gravados
5. A migração inicial está versionada e roda em banco vazio
6. Nenhum valor monetário aparece como `double` em qualquer camada
7. Nenhum identificador é gerado pelo banco
8. `flutter test` passa
9. Existe um comando único que roda todo o portão localmente

## Casos de teste

- Criar cliente com campos mínimos → persiste e é recuperável por id
- Criar cliente sem nome → rejeitado pela camada de domínio, não pelo banco
- Atualizar cliente → `atualizadoEm` muda, `criadoEm` não
- Remover documento → seus itens são removidos junto; nenhum item órfão permanece
- Criar item de documento sem `itemCatalogoId` (item avulso) → aceito
- Criar dois clientes em sequência → ids diferentes, ambos UUID válidos
- Gravar 1234 centavos → recuperar exatamente 1234, sem conversão intermediária para ponto flutuante
- Gravar data em fuso local → recuperar em UTC, valor equivalente
- Listar itens de catálogo inativos → não aparecem na listagem padrão
- Reabrir o banco após fechar → todos os registros permanecem

## Decisões travadas aplicáveis

`instructions.md` seções 3 (stack), 4 (arquitetura, regras 1, 2 e 5) e 5 (tipagem Dart). `bootstrap.md` seção 6.

## Decisões vedadas ao executor

Alterar os campos ou a cardinalidade das entidades acima. Acrescentar qualquer dependência. Trocar Drift, Riverpod ou a estrutura de camadas. Introduzir geração de código além da que o Drift já exige. Criar entidade nova não listada.

## Portão

```
flutter analyze
dart format --set-exit-if-changed .
flutter test
flutter build apk --debug
```

Saída real de cada comando anexada ao relatório.

## Riscos conhecidos

A geração de código do Drift costuma ser a primeira fonte de atrito, e o erro aparece como falha de build sem causa óbvia. A separação de camadas tende a vazar: o caminho mais curto é a entidade de domínio herdar da classe gerada pelo Drift, e isso quebra a regra 1 de arquitetura — se aparecer, é para parar e reportar, não para contornar. O mapeamento de data e fuso é onde mais se erra silenciosamente, e o teste de ida e volta é o que pega.

# Material de entrada do ciclo 01

Referência visual. **Não é fonte de verdade e não é código de origem.**

Os arquivos vieram do projeto Stitch `189806805668963139` ("App Orçamentos
Técnico Autônomo"), baixados em 2026-09-11 pela API do próprio Stitch. O conteúdo
de cada imagem foi conferido contra o nome — o mapeamento abaixo não é por
suposição.

## As seis telas da lista do ciclo

| Arquivo | Tela no Stitch | Dimensão |
|---|---|---|
| `01-quote-list.jpg` | Orçamentos (Lista) | 487×1437 |
| `02-new-quote-customer.jpg` | Novo Orçamento — Cliente (Etapa 1 de 3) | 487×1290 |
| `03-quote-items.jpg` | Novo Orçamento — Itens (Etapa 2 de 3) | 492×2042 |
| `04-catalog-picker.jpg` | Novo Orçamento — Adicionar Item (Catálogo Completo) | 487×1305 |
| `05-preview-share.png` | Novo Orçamento — Prévia e Envio (Etapa 3 de 3) | 780×2734 |
| `06-catalog.png` | Catálogo de Preços (Gerenciamento) | 780×2770 |

Extensão `.jpg` onde o Stitch guardou JPEG e `.png` onde guardou PNG. O brief do
ciclo escreve `.png` para todas; renomear extensão sem reconverter só produziria
arquivo com extensão mentirosa.

## Acrescentados fora da lista

`EmptyState` é componente obrigatório do ciclo 01 e **nenhuma das seis telas
acima é um estado vazio**. As duas telas abaixo existem no projeto Stitch e são a
única referência visual desse componente:

| Arquivo | Tela no Stitch | Dimensão |
|---|---|---|
| `07-quote-list-empty.jpg` | Orçamentos (Estado Vazio) | 487×985 |
| `08-catalog-empty.png` | Catálogo de Preços (Estado Vazio) | 780×1768 |

Se João preferir manter a lista fechada em seis, o `EmptyState` passa a não ter
referência e a regra "tela sem imagem correspondente não é implementada por
dedução" o deixa de fora do ciclo.

## `design-system.md`

Design system "Field Ops Native", exportado do Stitch: tokens completos em YAML
(paleta, escala tipográfica Inter, raios, espaçamentos) seguidos da especificação
em markdown.

Por D-008 ele é a **fonte provisória de tokens** do ciclo 01, no lugar de
`prompt-stitch.md`, que não existe no repositório. Isso inverte a premissa do
ciclo — Stitch como fonte de verdade — e a inversão é deliberada, registrada, e
deve ser reconciliada quando `prompt-stitch.md` chegar.

## `_raw/`

HTML gerado pelo Stitch. **Material de leitura.** Nunca importado, compilado ou
referenciado pelo projeto; está no `.gitignore`.

Inclui uma nona tela, `EXTRA-novo-orcamento-previa-do-documento.html`, que existe
no projeto Stitch mas não está na lista do ciclo — é uma variante da tela 5.

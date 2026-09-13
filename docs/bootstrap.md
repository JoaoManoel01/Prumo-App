# bootstrap.md — Preparação do repositório e da linha de inputs

Documento de partida. Consumido **uma vez**, pelo Claude Code, antes de existir qualquer código.

Projeto: **Prumo** (nome de trabalho, descartável — ver `docs/instructions-brandkit.md`)

O objetivo desta rodada não é escrever o aplicativo. É montar a estrutura que vai **produzir e consumir** os inputs dos ciclos seguintes. Nenhuma tela, nenhuma regra de negócio, nenhuma dependência além das declaradas.

---

## 1. O que deve existir ao fim desta rodada

```
prumo/
├── README.md
├── docs/
│   ├── context.md                    (já existe — mover para cá)
│   ├── instructions.md               (já existe — mover para cá)
│   ├── instructions-seguranca.md     (já existe — mover para cá)
│   ├── instructions-brandkit.md      (já existe — mover para cá)
│   ├── decisoes.md                   (criar vazio, com o cabeçalho de formato)
│   ├── marca/                        (criar vazio)
│   └── ciclos/
│       ├── _template-ciclo.md        (criar — seção 3)
│       └── ciclo-00-fundacao.md      (já existe — mover para cá)
├── app/                              (projeto Flutter)
├── api/
│   └── README.md                     (apenas: "Fase 2. Nada aqui até o ciclo 5.")
└── .github/workflows/
    └── portao.yml
```

Substituir `<NOME_DO_PROJETO>` por `Prumo` em todos os documentos, com um aviso no README de que é nome de trabalho.

---

## 2. Cadeia de documentos

Hierarquia de autoridade, do mais forte ao mais fraco. Em conflito, o de cima vence.

1. `docs/instructions.md` — como se constrói. Prevalece sobre tudo.
2. `docs/instructions-seguranca.md` — auditoria. Prevalece sobre entrega.
3. `docs/context.md` — o que se constrói e por quê. Resolve dúvida de escopo.
4. `docs/ciclos/ciclo-NN-*.md` — o que se constrói **agora**. Escopo fechado.
5. `docs/decisoes.md` — memória. Não manda, mas impede refazer discussão encerrada.

**O que o executor recebe em cada ciclo:** `instructions.md`, `context.md`, o brief do ciclo corrente e o código existente. Nada mais. Brief de ciclo antigo não entra — se algo dele ainda vale, está em `decisoes.md`.

**O que o executor nunca recebe autoridade para mudar:** qualquer arquivo em `docs/`. Documento é input, não saída de ciclo.

---

## 3. Template de brief de ciclo

Criar em `docs/ciclos/_template-ciclo.md`. É o artefato que alimenta cada rodada, e nenhum ciclo começa sem ele preenchido.

```markdown
# Ciclo NN — Título
Fase: 1 | 2 | 3
Data de abertura:

## Objetivo
Uma frase. Se precisar de duas, o ciclo está grande demais.

## Escopo incluso
Lista fechada e numerada. O que não está aqui não é para ser feito.

## Escopo excluído
O que alguém poderia razoavelmente achar que entra, e não entra. Seção obrigatória.

## Pré-requisitos
O que precisa estar pronto antes. Ciclo com pré-requisito pendente não abre.

## Critérios de aceite
Verificáveis, no imperativo, sem adjetivo. "Abre a tela" é critério; "funciona bem" não é.

## Casos de teste
Escritos ANTES da implementação, derivados dos critérios de aceite.
Cada caso: entrada, ação, resultado esperado.

## Decisões travadas aplicáveis
Referência às linhas de instructions.md e decisoes.md que valem aqui.

## Decisões vedadas ao executor
O que, se aparecer como necessário, obriga a parar e perguntar.

## Portão
Comandos exatos que precisam passar. Cópia da saída entra no relatório.

## Riscos conhecidos
O que provavelmente vai dar errado, para não virar surpresa.
```

---

## 4. Pronto para abrir e pronto para fechar

**Um ciclo está pronto para abrir quando:** o brief existe preenchido; escopo incluso e excluído estão escritos; os critérios de aceite são verificáveis; os casos de teste estão escritos; os pré-requisitos estão fechados; e o portão roda no repositório atual.

**Um ciclo está pronto para fechar quando:** todo item do escopo incluso está consolidado ou explicitamente registrado como não consolidado; o portão passou com a saída real anexada; nenhum arquivo fora do escopo foi tocado; nenhuma dependência não aprovada entrou; as decisões técnicas do ciclo estão em `decisoes.md` com alternativa e custo; e o relatório segue a seção 11 de `instructions.md`.

Relatório afirmando sucesso sem saída de portão não fecha ciclo.

---

## 5. Portão automático

`.github/workflows/portao.yml`, rodando em cada push e pull request. Nesta rodada ele roda praticamente vazio — é intencional: o portão nasce antes do código, não depois.

Fase 1: `flutter analyze` em modo estrito (sem aviso tolerado), `dart format --set-exit-if-changed`, `flutter test`, `flutter build apk --debug`.
Fase 2, quando existir: `mypy --strict`, `ruff check`, `pytest`.

O mesmo conjunto precisa rodar localmente por um comando único, para o ciclo não depender do CI para saber que falhou.

---

## 6. Decisões desta rodada que precisam ficar registradas

Registrar em `docs/decisoes.md` no formato da seção 10 de `instructions.md`:

- **Dinheiro em inteiro de centavos, nunca ponto flutuante.** Decisão irreversível na prática: mudar depois exige migração de dados. Alternativa descartada: `double`, por erro de arredondamento acumulado em soma de itens.
- **Identificador UUID gerado no cliente.** Para permitir criação offline e sincronização futura sem colisão. Alternativa descartada: autoincremento do banco.
- **Data e hora em UTC no armazenamento, conversão só na exibição.**
- **Drift em vez de sqflite cru.** Consulta verificada em compilação.
- **Nomes de domínio em português.** Decisão de João, a confirmar.

---

## 7. Limites desta rodada

Não criar tela, widget de interface, rota de navegação, tema visual, lógica de cálculo de orçamento, geração de PDF nem qualquer dependência fora das já declaradas em `instructions.md`.

Se algo parecer necessário e não estiver aqui, parar e perguntar. Esta rodada é a que estabelece o hábito: escopo fechado vale mais que progresso.

---

## 8. Entrega desta rodada

1. Árvore de arquivos criada, com os documentos movidos e o placeholder de nome substituído
2. Projeto Flutter inicializado, compilando
3. Portão rodando, verde, ainda sem teste relevante
4. `docs/decisoes.md` com os registros da seção 6
5. Relatório no formato da seção 11 de `instructions.md`
6. Uma lista do que ficou ambíguo neste documento e precisou de interpretação — essa lista é o insumo para melhorar o próximo brief

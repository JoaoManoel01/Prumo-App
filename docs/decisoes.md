# decisoes.md — Memória de decisões

Não manda: impede refazer discussão encerrada. Em conflito com `instructions.md`,
`instructions-seguranca.md`, `context.md` ou o brief do ciclo corrente, este
documento perde.

> **Formato provisório.** A seção 10 de `instructions.md` define o formato
> canônico deste arquivo. Esse documento ainda não foi depositado no repositório
> (ver `docs/_FALTANDO.md`), então o formato abaixo é uma interpretação e deve
> ser reconciliado quando `instructions.md` chegar.

Cada entrada traz: o que foi decidido, por quê, a alternativa descartada com o
motivo, e o custo de reverter.

---

## D-001 — Dinheiro em inteiro de centavos, nunca ponto flutuante

**Data:** 2026-09-11 · **Origem:** `bootstrap.md` §6

Todo valor monetário trafega e é persistido como `int` de centavos, em qualquer
camada.

- **Alternativa descartada:** `double`. Erro de arredondamento acumula na soma de
  itens de um orçamento, e o erro aparece no documento que vai para o cliente.
- **Custo de reverter:** alto e irreversível na prática. Mudar depois exige
  migração de dados já gravados no aparelho do usuário.

## D-002 — Identificador UUID v4 gerado no cliente

**Data:** 2026-09-11 · **Origem:** `bootstrap.md` §6

Todo identificador de entidade é UUID v4 gerado no aparelho, nunca pelo banco.

- **Alternativa descartada:** autoincremento do banco. Impede criação offline sem
  risco de colisão quando a sincronização da fase 2 existir.
- **Custo de reverter:** alto. Muda chave primária e toda referência cruzada.

## D-003 — Data e hora em UTC no armazenamento

**Data:** 2026-09-11 · **Origem:** `bootstrap.md` §6

Armazenamento sempre em UTC. Conversão para fuso local acontece só na exibição.

- **Alternativa descartada:** gravar em fuso local. Quebra silenciosamente em
  viagem, em mudança de horário de verão e na sincronização entre aparelhos.
- **Custo de reverter:** médio. Exige migração com reinterpretação de cada
  registro já gravado, e o erro é silencioso.

## D-004 — Drift em vez de sqflite cru

**Data:** 2026-09-11 · **Origem:** `bootstrap.md` §6

- **Alternativa descartada:** sqflite com SQL em string. Consulta só quebra em
  execução; com Drift, quebra em compilação.
- **Custo de reverter:** médio. Reescreve a camada `dados/`, preserva o domínio.

## D-005 — Nomes de domínio em português

**Data:** 2026-09-11 · **Origem:** `bootstrap.md` §6 · **Status: a confirmar por João**

Entidades, campos e repositórios em português (`Cliente`, `precoPadraoCentavos`,
`estadoSincronizacao`), como já fixado no `ciclo-00-fundacao.md`.

- **Alternativa descartada:** inglês. O domínio é falado em português pelo usuário
  e pelo autor; traduzir o vocabulário do negócio introduz um degrau de tradução
  em toda conversa sobre o código.
- **Custo de reverter:** médio antes do ciclo 00 estar consolidado; alto depois.
- **Pendência:** `bootstrap.md` §6 marca esta decisão como "a confirmar".
  Ver tensão com D-007.

---

## Decisões tomadas na rodada de bootstrap

## D-006 — Toolchain instalada fora do OneDrive

**Data:** 2026-09-11

Flutter 3.47.4 stable em `C:\dev\flutter`, Android SDK em `C:\dev\android-sdk`,
JDK 17 (Microsoft OpenJDK 17.0.20) como `JAVA_HOME`.

- **Motivo:** a máquina não tinha Flutter, Dart, Android SDK nem JDK compatível.
  A JDK 25 já instalada é nova demais para o Gradle que o Flutter gera.
- **Alternativa descartada:** Android Studio completo. Traz IDE e emulador que
  este fluxo não usa, e o assistente gráfico não é automatizável.
- **Custo de reverter:** baixo. É ambiente, não código.

## D-007 — Camada de apresentação nomeada `presentation/`, em inglês

**Data:** 2026-09-11 · **Decisão de João** · **Status: em tensão com D-005**

O `ciclo-00-fundacao.md` escreve `apresentacao/`; o brief do ciclo 01 escreve
`presentation/` e `components/`. Perguntado, João escolheu inglês.

- **Consequência:** `ciclo-00-fundacao.md` precisa ser corrigido antes de abrir,
  porque hoje ele contradiz esta decisão.
- **Tensão não resolvida:** D-005 fixa português para nomes de domínio. Convivem
  se a regra for "domínio em português, camadas de infraestrutura e apresentação
  em inglês", mas essa regra ainda não está escrita em lugar nenhum. Quando
  `instructions.md` chegar, ela decide.
- **Custo de reverter:** baixo agora (nenhum arquivo criado ainda nessa pasta),
  alto depois do ciclo 01.

## D-008 — Design system do Stitch como fonte provisória de tokens

**Data:** 2026-09-11 · **Decisão de João**

`prompt-stitch.md` não existe no repositório. Os tokens do ciclo 01 saem de
`docs/ui/stitch/design-system.md`, extraído do próprio projeto Stitch.

- **Consequência:** contraria a premissa do ciclo 01, que diz que o Stitch é
  referência visual e não fonte de verdade. A inversão é deliberada e fica
  registrada em `docs/ui/divergencias.md` quando o ciclo 01 abrir.
- **Alternativa descartada:** bloquear o ciclo 01 até `prompt-stitch.md` existir.
- **Custo de reverter:** baixo. Quando `prompt-stitch.md` chegar, os tokens são
  reconciliados contra ele e a divergência é fechada.

## D-009 — Projeto Flutter restrito à plataforma Android

**Data:** 2026-09-11

`flutter create --platforms android`, org `com.prumo`, nome `prumo`.

- **Motivo:** o portão só exige `flutter build apk --debug`, e o próprio briefing
  de produto descreve um aplicativo Android nativo para uso em campo.
- **Alternativa descartada:** todas as plataformas por padrão. Traz pastas iOS,
  web e desktop que nenhum ciclo previsto usa, e o doctor já reprova o desktop
  Windows por falta de Visual Studio.
- **Custo de reverter:** baixo. `flutter create --platforms=<novas> .` reintroduz.
- **Pendência:** `com.prumo` foi escolhido por falta de `context.md`. Se o
  identificador de aplicação importa para publicação, revisar antes do ciclo 02 —
  mudar `applicationId` depois de publicar é impossível.

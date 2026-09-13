# Documentos ausentes

O `bootstrap.md` §1 descreve os quatro documentos abaixo como "já existe — mover
para cá". Nenhum deles estava no repositório quando o bootstrap foi executado em
2026-09-11. Eles **não foram criados nem reconstituídos**: inventar o topo da
cadeia de autoridade seria inventar a lei do projeto.

| Documento | Papel na cadeia (`bootstrap.md` §2) | Consequência de continuar sem ele |
|---|---|---|
| `docs/instructions.md` | **1 — prevalece sobre tudo.** Como se constrói. | Seção 3 (stack), 4 (arquitetura), 5 (tipagem) e 10 (formato de `decisoes.md`) são citadas pelo ciclo 00 e não podem ser verificadas. O formato de `decisoes.md` foi interpretado. A tensão D-005 × D-007 fica sem árbitro. |
| `docs/instructions-seguranca.md` | **2 — prevalece sobre entrega.** Auditoria. | Nenhum critério de auditoria é aplicável. Nenhum ciclo pode ser auditado. |
| `docs/context.md` | **3 —** o que se constrói e por quê. | Dúvida de escopo não tem onde ser resolvida. O `applicationId` `com.prumo` foi escolhido sem base (D-009). |
| `docs/instructions-brandkit.md` | Identidade. Citado no cabeçalho do `bootstrap.md`. | O nome "Prumo" está marcado como descartável e só este documento diz o que o substitui. |

Além destes, o ciclo 01 depende de:

| Documento | Papel | Situação |
|---|---|---|
| `prompt-stitch.md` | Fonte dos tokens; vence o esboço em caso de divergência. | Ausente. Contornado por D-008, que usa o design system extraído do Stitch como fonte provisória. |

Quando cada documento for depositado, apagar a linha correspondente desta tabela
e reconciliar o que dependia dele.

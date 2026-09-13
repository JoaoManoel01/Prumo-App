# Prumo

> **"Prumo" é nome de trabalho e descartável.** A identidade definitiva sai de
> `docs/instructions-brandkit.md`, que ainda não está no repositório
> (ver `docs/_FALTANDO.md`). Trocar o nome depois custa: `applicationId`,
> pacote Java e diretório do projeto.

Aplicativo Android para prestador de serviço técnico autônomo — refrigeração,
elétrica, hidráulica, instalação — montar orçamento na casa do cliente, offline,
com o celular na mão.

## Estrutura

```
.
├── app/                    projeto Flutter (Android)
├── api/                    fase 2, vazio até o ciclo 5
├── docs/
│   ├── bootstrap.md        consumido uma vez, em 2026-09-11
│   ├── decisoes.md         memória de decisões
│   ├── _FALTANDO.md        documentos da cadeia de autoridade ainda ausentes
│   ├── ciclos/             briefs, um por ciclo
│   ├── marca/              vazio
│   └── ui/stitch/          referência visual do ciclo 01
├── tool/portao.ps1         o portão, em um comando
└── .github/workflows/      o portão, no CI
```

## Cadeia de autoridade

Do mais forte ao mais fraco; em conflito, o de cima vence.

1. `docs/instructions.md` — como se constrói **· ausente**
2. `docs/instructions-seguranca.md` — auditoria **· ausente**
3. `docs/context.md` — o que se constrói e por quê **· ausente**
4. `docs/ciclos/ciclo-NN-*.md` — o que se constrói agora
5. `docs/decisoes.md` — memória

Três dos cinco níveis não existem. Enquanto for assim, decisão que dependeria
deles fica registrada como interpretação em `decisoes.md`, não como fato.

## Portão

```powershell
powershell -File tool\portao.ps1
```

Roda `flutter analyze` estrito, `dart format --set-exit-if-changed`,
`flutter test` e `flutter build apk --debug`, nessa ordem, parando no primeiro
que falhar. É o mesmo conjunto que `.github/workflows/portao.yml` roda em cada
push e pull request.

## Ambiente

Flutter 3.47.4 stable (Dart 3.13.3) em `C:\dev\flutter`, Android SDK 36 em
`C:\dev\android-sdk`, JDK 17 como `JAVA_HOME`. Instalado em 2026-09-11; ver D-006.

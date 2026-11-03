# Linktree · Moreira · Oliveira Advocacia

Página de links do escritório, publicada em **moreiraoliveira.adv.br/links**.

## Estrutura

```
links/
  index.html                         página (HTML, CSS e JS num arquivo só)
  assets/                            logo, monograma, trama, capa e PDF do material VDMA
_redirects                           moreiraoliveira.adv.br → /links/ (Netlify)
```

## Editar links e contatos

No fim de `links/index.html`, no bloco `PERFIL`:

- `whatsapp`, `mensagemWhatsapp`: número e mensagem pronta
- `email`, `assuntoEmail`: e-mail e assunto
- `site`: site institucional
- `pdf`: material para download
- `umamiId`: ID do contador de cliques (cloud.umami.is)

## Hospedagem

Feito para o **Netlify**: o formulário de nome e e-mail usa o Netlify Forms (`ebook-vdma`).
Conecte este repositório no Netlify (Add new project → Import from GitHub), sem comando de build e com a pasta de publicação na raiz.
Depois ative **Forms → Enable form detection**.

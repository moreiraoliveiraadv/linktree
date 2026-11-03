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
- `supabaseUrl`, `supabaseKey`: projeto Supabase e chave pública (anon/publishable)
- `umamiId`: contador de cliques extra, opcional (cloud.umami.is)

## Supabase (nomes, e-mails e cliques)

1. No Supabase, abra **SQL Editor**, cole `supabase/schema.sql` e rode.
2. Em **Project Settings › API**, copie a URL do projeto e a chave pública para o bloco `PERFIL`.
3. Pronto: os contatos vão para a tabela `leads` e os cliques para `cliques`.
   Relatórios prontos: `leads_unicos`, `resumo_cliques`, `cliques_por_dia`.

A página só consegue **inserir**; ninguém lê os dados por ela.
Sem Supabase configurado, o formulário usa o Netlify Forms.

## Hospedagem

Feito para o **Netlify**: o formulário de nome e e-mail usa o Netlify Forms (`ebook-vdma`).
Conecte este repositório no Netlify (Add new project → Import from GitHub), sem comando de build e com a pasta de publicação na raiz.
Depois ative **Forms → Enable form detection**.

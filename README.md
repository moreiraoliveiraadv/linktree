# Linktree · Moreira · Oliveira Advocacia

Site do escritório em **moreiraoliveira.adv.br**:

- `/` página provisória: logomarca e botão de contato pelo WhatsApp
- `/links/` página de links

## Estrutura

```
index.html                           página provisória da raiz (logo + WhatsApp, arquivo único)
links/
  index.html                         página (HTML, CSS e JS num arquivo só)
  assets/                            logo, monograma, trama, capa e PDF do material VDMA
_redirects                           /links → /links/ (Netlify)
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

Site estático, sem comando de build: publique a raiz do repositório.

- **Vercel**: Add New › Project › importe este repositório › Deploy. O `vercel.json` só acrescenta a barra final (`/links` → `/links/`).
- **Netlify**: Add new project › Import from GitHub. O `_redirects` faz o mesmo.

A página provisória da raiz é o `index.html`. Para trocar o número do WhatsApp, edite o link `wa.me` no botão.

Depois, ligue o domínio `moreiraoliveira.adv.br` no painel da hospedagem e crie no Registro.br os registros que ela indicar
(sem mexer nos registros MX do Google, que são do e-mail).

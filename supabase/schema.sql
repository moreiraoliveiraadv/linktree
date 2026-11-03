-- =====================================================================
-- Linktree · Moreira · Oliveira Advocacia — banco no Supabase
-- Cole tudo no Supabase › SQL Editor › New query e clique em Run.
-- Pode rodar de novo sem problema: o script não apaga dados.
--
-- Segurança: a página usa a chave pública (anon/publishable).
-- Com as regras abaixo ela só consegue INSERIR. Ninguém lê, altera ou
-- apaga dados pela página; a leitura é feita só por você no painel.
-- =====================================================================

create extension if not exists pgcrypto;

-- ---------------------------------------------------------------------
-- 1. Leads: quem preencheu nome e e-mail para baixar o material
-- ---------------------------------------------------------------------
create table if not exists public.leads (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamptz not null default now(),
  nome        text not null check (char_length(nome) between 2 and 120),
  email       text not null check (
                char_length(email) <= 200
                and email ~* '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]{2,}$'
              ),
  material    text not null default 'reforma-tributaria-vdma'
                check (char_length(material) <= 80),
  pagina      text check (char_length(pagina) <= 300),
  dispositivo text check (dispositivo in ('celular', 'computador'))
);

create index if not exists leads_created_at_idx on public.leads (created_at desc);
create index if not exists leads_email_idx      on public.leads (lower(email));

alter table public.leads enable row level security;

drop policy if exists "linktree insere leads" on public.leads;
create policy "linktree insere leads"
  on public.leads for insert
  to anon
  with check (true);

revoke all    on public.leads from anon, authenticated;
grant  insert on public.leads to anon;


-- ---------------------------------------------------------------------
-- 2. Cliques: contador de cada botão da página
-- ---------------------------------------------------------------------
-- Eventos enviados pela página:
--   ebook-clique, ebook-lead, ebook-download, whatsapp, whatsapp-flutuante,
--   email, site, site-topo, compartilhar, visita
create table if not exists public.cliques (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamptz not null default now(),
  evento      text not null check (evento ~ '^[a-z0-9-]{1,40}$'),
  pagina      text check (char_length(pagina) <= 300),
  origem      text check (char_length(origem) <= 300),
  dispositivo text check (dispositivo in ('celular', 'computador'))
);

create index if not exists cliques_evento_data_idx on public.cliques (evento, created_at desc);

alter table public.cliques enable row level security;

drop policy if exists "linktree insere cliques" on public.cliques;
create policy "linktree insere cliques"
  on public.cliques for insert
  to anon
  with check (true);

revoke all    on public.cliques from anon, authenticated;
grant  insert on public.cliques to anon;


-- ---------------------------------------------------------------------
-- 3. Relatórios (abra em Table Editor › Views, ou rode um SELECT)
--    security_invoker: a página não consegue ler estes relatórios.
-- ---------------------------------------------------------------------

-- Um contato por e-mail, com a data mais recente
create or replace view public.leads_unicos
with (security_invoker = true) as
select distinct on (lower(email))
  nome,
  lower(email)     as email,
  material,
  dispositivo,
  created_at       as data
from public.leads
order by lower(email), created_at desc;

-- Total de cliques por botão
create or replace view public.resumo_cliques
with (security_invoker = true) as
select
  evento,
  count(*)                                                         as total,
  count(*) filter (where created_at >= now() - interval '7 days')  as ultimos_7_dias,
  count(*) filter (where created_at >= now() - interval '30 days') as ultimos_30_dias,
  count(*) filter (where dispositivo = 'celular')                  as no_celular,
  max(created_at)                                                  as ultimo_clique
from public.cliques
group by evento
order by total desc;

-- Cliques por dia (últimos 90 dias)
create or replace view public.cliques_por_dia
with (security_invoker = true) as
select
  (created_at at time zone 'America/Sao_Paulo')::date as dia,
  evento,
  count(*) as total
from public.cliques
where created_at >= now() - interval '90 days'
group by 1, 2
order by 1 desc, 3 desc;

revoke all on public.leads_unicos, public.resumo_cliques, public.cliques_por_dia from anon, authenticated;


-- ---------------------------------------------------------------------
-- Consultas úteis (rode no SQL Editor quando quiser)
-- ---------------------------------------------------------------------
-- select * from public.leads_unicos order by data desc;
-- select * from public.resumo_cliques;
-- select * from public.cliques_por_dia;

-- Ejecutar en Supabase → SQL Editor

create table if not exists public.recetas (
  id uuid primary key default gen_random_uuid(),
  nombre text not null,
  descripcion text,
  tiempo_minutos integer,
  categoria text,
  created_at timestamptz not null default now()
);

alter table public.recetas enable row level security;

drop policy if exists "lectura_publica" on public.recetas;
drop policy if exists "autenticados_insertan" on public.recetas;
drop policy if exists "autenticados_actualizan" on public.recetas;
drop policy if exists "autenticados_eliminan" on public.recetas;

create policy "lectura_publica"
  on public.recetas
  for select
  using (true);

create policy "autenticados_insertan"
  on public.recetas
  for insert
  to authenticated
  with check (true);

create policy "autenticados_actualizan"
  on public.recetas
  for update
  to authenticated
  using (true)
  with check (true);

create policy "autenticados_eliminan"
  on public.recetas
  for delete
  to authenticated
  using (true);

insert into public.recetas (nombre, descripcion, tiempo_minutos, categoria)
values
  ('Arepa con queso', 'Arepa asada rellena de queso campesino.', 20, 'Desayuno'),
  ('Huevos pericos', 'Huevos revueltos con tomate y cebolla.', 15, 'Desayuno'),
  ('Arroz con pollo', 'Arroz amarillo con verduras y pollo desmechado.', 45, 'Almuerzo'),
  ('Pasta al ajo', 'Espagueti con ajo, aceite y perejil.', 25, 'Cena'),
  ('Sopa de tomate', 'Crema de tomate con albahaca.', 30, 'Almuerzo'),
  ('Tostada de aguacate', 'Pan tostado, aguacate, limón y sal.', 10, 'Desayuno'),
  ('Brownie rápido', 'Brownie de cacao en un solo bowl.', 35, 'Postre'),
  ('Ensalada de mango', 'Mango, pepino, limón y cilantro.', 12, 'Almuerzo');

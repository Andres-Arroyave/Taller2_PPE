# Cocina Fácil — Taller 2

Proyecto Astro con **arquitectura híbrida**: listado público en **SSR** y páginas de administración / “Acerca de” en **SSG**, autenticación con **Supabase** y despliegue en un **Cloudflare Worker**.

**URL pública (Cloudflare):** _pendiente de desplegar — pega aquí la URL del Worker cuando esté en línea._

## Qué cumple

| Requisito | Cómo |
|---|---|
| Listado público SSR | `/` con `export const prerender = false`. Consulta Supabase **en el servidor** en cada request. |
| Búsqueda y paginación | `/?q=arepa&page=2` resuelto en el servidor. El formulario es GET (funciona sin JavaScript). |
| Nombres en el HTML | Los `<h2>` de cada receta se renderizan en el HTML. Ver con **Ctrl + U**. |
| CRUD SSG | `/admin`, `/admin/nueva`, `/admin/editar` con `export const prerender = true`. Datos con Supabase **desde el cliente**. |
| Auth + RLS | Registro, login y redirección a `/login` si no hay sesión. Escritura solo para `authenticated`. |
| Acerca de | `/acerca-de` pre-renderizada. |
| View Transitions | Layout con `<ClientRouter />` y `<title>` por página. |
| Cloudflare Worker | Adaptador `@astrojs/cloudflare`. |

## 1. Supabase

1. Crea un proyecto en [supabase.com](https://supabase.com).
2. En **SQL Editor** ejecuta `supabase/schema.sql` (tabla `recetas`, políticas RLS y datos de ejemplo).
3. En **Authentication → Providers → Email** deja el correo habilitado. Para la demo de clase, desactiva **Confirm email** (así el registro entra de inmediato).
4. Copia **Project URL** y **anon public** key en Project Settings → API.

## 2. Arrancar en local

```bash
cd cocina-facil
cp .env.example .env
```

Edita `.env`:

```
PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOi...
```

```bash
npm install
npm run dev
```

Abre `http://localhost:4321`.

- Listado: `/`
- Búsqueda: `/?q=arepa&page=1`
- Acerca de: `/acerca-de`
- Registro / login: `/registro` y `/login`
- CRUD: `/admin` (pide sesión)

## 3. Cómo se verifica el taller

1. En el listado, **Ctrl + U**: deben verse los nombres de las recetas en el HTML, incluso con JavaScript deshabilitado.
2. En `/admin` sin sesión: redirige a `/login`.
3. Con sesión: crear, editar y borrar recetas. En **Ctrl + U** de `/admin` **no** deben aparecer esas recetas en el HTML (llegan después, desde el cliente).
4. Al navegar, el layout se mantiene y el `<title>` cambia (View Transitions).

## 4. Desplegar en Cloudflare Worker

1. Crea una cuenta en [Cloudflare](https://dash.cloudflare.com) e instala/inicia sesión:

```bash
npx wrangler login
```

2. En el dashboard de Cloudflare (Workers) o al construir, define las mismas variables:

- `PUBLIC_SUPABASE_URL`
- `PUBLIC_SUPABASE_ANON_KEY`

Si construyes en tu máquina:

```bash
npm run build
npx wrangler deploy
```

`wrangler` publicará el Worker. Copia la URL (algo como `https://cocina-facil.<cuenta>.workers.dev`) y pégala arriba en este README.

También puedes conectar el repo de GitHub a **Workers Builds** / Cloudflare y usar esas variables de entorno en el panel.

## Estructura

```
src/pages/index.astro          SSR — listado, búsqueda, paginación
src/pages/acerca-de.astro      SSG
src/pages/login.astro          SSG
src/pages/registro.astro       SSG
src/pages/admin/*              SSG — CRUD en el cliente
src/layouts/Layout.astro       ClientRouter + title
supabase/schema.sql            tabla + RLS
```

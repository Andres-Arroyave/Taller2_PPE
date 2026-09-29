# 🍳 Cocina Fácil — Taller 2

Proyecto desarrollado con **Astro** desplegado sobre la **arquitectura híbrida de Cloudflare Workers** con persistencia y autenticación mediante **Supabase**.

🌐 **URL desplegada en producción (Cloudflare Worker):**
[https://cocina-facil.cocina-facil-app.workers.dev](https://cocina-facil.cocina-facil-app.workers.dev)

---

## 📌 Cumplimiento de Requerimientos (Taller #2)

| Sección | Requisito | Implementación |
|---|---|---|
| **SSR (Dinámico)** | Listado público desde el servidor | `src/pages/index.astro` (`export const prerender = false`) consulta Supabase en cada request en el servidor. |
| **SSR (Dinámico)** | Búsqueda por nombre y paginación | Query params `/?q=...&page=...` resueltos en el servidor vía `Astro.url.searchParams`. |
| **SSR (Dinámico)** | Elementos siempre visibles en HTML | Renders dinámicos inyectados en HTML inicial (`Ctrl + U` muestra las recetas sin JS). |
| **SSG (Estático)** | "Acerca de" pre-renderizado | `src/pages/acerca-de.astro` (`export const prerender = true`). |
| **SSG (Estático)** | Auth + CRUD pre-renderizados | `login.astro`, `registro.astro`, `admin/index.astro`, `admin/nueva.astro`, `admin/editar.astro` (`export const prerender = true`). |
| **Autenticación** | Operaciones cliente y RLS | Consultas CRUD e inicio de sesión desde el cliente con RLS en PostgreSQL Supabase y guardias de navegación (`requireSession()`). |
| **Transiciones** | Navigation & View Transitions | `src/layouts/Layout.astro` incluye `<ClientRouter />` y `<title>` dinámico por página. |
| **Despliegue** | Cloudflare Worker | Adaptador `@astrojs/cloudflare` en `astro.config.mjs` y configuración `wrangler.jsonc`. |

---

## 💻 Requisitos Previos en Windows

Antes de levantar el proyecto en una máquina Windows, asegúrate de tener instalado:

1. **Node.js**: Versión `>= 22.12.0` (recomendado Node.js LTS). Puedes verificarlo en terminal con `node -v`.
2. **Git** (opcional, para clonar el repositorio).
3. **Cuenta de Supabase** (gratuita en [supabase.com](https://supabase.com)).
4. **Cuenta de Cloudflare** (gratuita en [cloudflare.com](https://cloudflare.com)).

---

## 🚀 Paso a Paso: Levantar el Proyecto en Windows

### Paso 1: Obtener el código e ingresar a la carpeta
Abre **PowerShell** o **CMD** en la ubicación deseada y navega a la carpeta del proyecto:

```powershell
cd cocina-facil
```

---

### Paso 2: Instalar las dependencias
Ejecuta el siguiente comando para instalar todos los paquetes requeridos por Astro, Cloudflare y Supabase:

```powershell
npm install
```

---

### Paso 3: Configurar las Variables de Entorno

1. Duplica o crea el archivo `.env` a partir de `.env.example`:

```powershell
Copy-Item .env.example .env
```

2. Abre el archivo `.env` en tu editor de código o Bloc de notas y configura la URL y Anon Key de tu proyecto Supabase:

```env
PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
PUBLIC_SUPABASE_ANON_KEY=tu-anon-key-publica
```

*(Nota: En [wrangler.jsonc](file:///c:/Users/arroy/Downloads/cocina-facil/cocina-facil/wrangler.jsonc) ya están configuradas las variables en la propiedad `"vars"` para el despliegue automático en Cloudflare).*

---

### Paso 4: Configurar la Base de Datos en Supabase

1. Entra a tu consola en [Supabase Dashboard](https://supabase.com/dashboard).
2. Selecciona tu proyecto y ve a la pestaña **SQL Editor** en el menú lateral izquierdo.
3. Copia el contenido completo del archivo [supabase/schema.sql](file:///c:/Users/arroy/Downloads/cocina-facil/cocina-facil/supabase/schema.sql) de este proyecto.
4. Pégalo en el editor SQL y haz clic en **Run**.
   * Esto creará la tabla `recetas`.
   * Activará la seguridad por filas (**RLS**).
   * Insertará los datos semilla iniciales.
5. En Supabase, ve a **Authentication -> Providers -> Email** y asegúrate de que el proveedor Email esté activo. *(Para pruebas rápidas de clase, puedes desactivar "Confirm email" para que los usuarios registrados inicien sesión de inmediato).*

---

### Paso 5: Iniciar el Servidor de Desarrollo Local

Ejecuta en tu terminal de Windows:

```powershell
npm run dev
```

El servidor estará corriendo en: **`http://localhost:4321`**

#### Rutas disponibles:
- 🏠 **Inicio (SSR):** `http://localhost:4321/` (Búsqueda y paginación)
- ℹ️ **Acerca de (SSG):** `http://localhost:4321/acerca-de`
- 🔑 **Iniciar sesión (SSG):** `http://localhost:4321/login`
- 📝 **Registro (SSG):** `http://localhost:4321/registro`
- ⚙️ **Panel Admin (SSG + Auth):** `http://localhost:4321/admin`

---

### Paso 6: Desplegar en Cloudflare Workers desde Windows

Si deseas volver a desplegar o actualizar la versión publicada en Cloudflare Workers desde tu máquina Windows:

1. Autentícate en Cloudflare a través de Wrangler:

```powershell
npx wrangler login
```
*(Se abrirá tu navegador para confirmar el acceso a tu cuenta de Cloudflare).*

2. Ejecuta el script de compilación y despliegue:

```powershell
npm run deploy
```

Al finalizar, la terminal devolverá tu URL pública activa en Cloudflare:
`https://cocina-facil.cocina-facil-app.workers.dev`

---

## 📁 Estructura del Proyecto

```text
cocina-facil/
├── src/
│   ├── layouts/
│   │   └── Layout.astro         # Layout principal con ClientRouter (View Transitions) y <title>
│   ├── lib/
│   │   ├── require-session.ts   # Guard para redirigir a /login si no hay sesión
│   │   ├── supabase-client.ts   # Cliente de Supabase para navegador (CRUD & Auth)
│   │   ├── supabase-server.ts   # Cliente de Supabase para servidor (SSR)
│   │   ├── types.ts             # Definiciones TypeScript (Receta, PAGE_SIZE)
│   │   └── url.ts               # Helper para generación de URLs de paginación
│   ├── pages/
│   │   ├── admin/
│   │   │   ├── editar.astro     # SSG — Edición de recetas en el cliente
│   │   │   ├── index.astro      # SSG — Listado de administración con sesión
│   │   │   └── nueva.astro      # SSG — Creación de recetas en el cliente
│   │   ├── acerca-de.astro      # SSG — Página informativa pre-renderizada
│   │   ├── index.astro          # SSR — Listado público, búsqueda y paginación
│   │   ├── login.astro          # SSG — Formulario de inicio de sesión
│   │   └── registro.astro       # SSG — Formulario de registro de usuario
│   └── styles/
│       └── global.css           # Estilos globales de la aplicación
├── supabase/
│   └── schema.sql               # Script SQL (Tablas, Políticas RLS y datos iniciales)
├── astro.config.mjs             # Configuración de Astro con adapter Cloudflare (hybrid mode)
├── wrangler.jsonc               # Configuración de Wrangler para Cloudflare Workers
├── package.json                 # Scripts e instalación de dependencias
└── README.md                    # Documentación del proyecto
```

---

## 🔍 Cómo verificar el correcto funcionamiento del Taller

1. **Verificación de SSR (Público):**
   - Entra a la página principal y presiona `Ctrl + U` (Ver código fuente).
   - Verifica que los nombres de las recetas aparecen en el código HTML enviado por el servidor (incluso si deshabilitas JavaScript).
2. **Verificación de SSG & Auth:**
   - Si intentas entrar a `/admin` sin haber iniciado sesión, serás redirigido automáticamente a `/login`.
   - Una vez iniciada la sesión, las operaciones de creación, edición y eliminación interactúan directamente con Supabase desde el cliente.
3. **Verificación de View Transitions:**
   - Navega entre las páginas del sitio; observa que la cabecera y el diseño se mantienen sin parpadeo y la etiqueta `<title>` se actualiza según la página visitada.

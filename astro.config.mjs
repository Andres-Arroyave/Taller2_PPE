// @ts-check
import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';

// Sitio híbrido: páginas estáticas por defecto (SSG) y SSR on-demand
// donde se exporta `prerender = false` (listado público).
export default defineConfig({
  adapter: cloudflare(),
  output: 'static',
});

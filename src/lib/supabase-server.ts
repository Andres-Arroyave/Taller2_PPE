import { createClient } from '@supabase/supabase-js';

/** Cliente de Supabase para el servidor (SSR). Sin sesión persistida. */
export function createServerClient() {
  const url = import.meta.env.PUBLIC_SUPABASE_URL;
  const key = import.meta.env.PUBLIC_SUPABASE_ANON_KEY;

  if (!url || !key) {
    throw new Error(
      'Faltan PUBLIC_SUPABASE_URL o PUBLIC_SUPABASE_ANON_KEY. Copia .env.example a .env',
    );
  }

  return createClient(url, key, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
      detectSessionInUrl: false,
    },
  });
}

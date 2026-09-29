import { createClient } from '@supabase/supabase-js';

const url = import.meta.env.PUBLIC_SUPABASE_URL;
const key = import.meta.env.PUBLIC_SUPABASE_ANON_KEY;

/** Cliente de Supabase para el navegador (CRUD y autenticación). */
export const supabase = createClient(url, key);

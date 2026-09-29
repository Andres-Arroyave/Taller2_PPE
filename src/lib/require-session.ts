import { supabase } from './supabase-client';

export async function requireSession(): Promise<boolean> {
  const { data } = await supabase.auth.getSession();
  if (data.session) return true;
  window.location.href = '/login';
  return false;
}

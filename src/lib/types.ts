export type Receta = {
  id: string;
  nombre: string;
  descripcion: string | null;
  tiempo_minutos: number | null;
  categoria: string | null;
  created_at: string;
};

export const PAGE_SIZE = 6;

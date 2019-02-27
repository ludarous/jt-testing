export interface ISport {
  id?: number;
  name?: string;
}

export class Sport implements ISport {
  id: number;
  name: string;
}

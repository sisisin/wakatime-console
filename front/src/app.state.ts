import { State } from 'walts';

export interface AppState extends State {
  summaries: IResSummary[];
}

export interface IResSummary {
  date: string;
  editors: any[];
  entities: any[];
  id: number;
  languages: any[];
  name: string;
  operating_systems: any[];
  total_seconds: number;
}

export interface IDayOfSummaries { [key: string]: IResSummary[] }
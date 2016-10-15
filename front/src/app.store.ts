import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Store } from 'walts';

import { AppState, IResSummary, IDayOfWeekSummaries, IDailySummaries } from './app.state';
import { AppDispatcher } from './app.dispatcher';

function getInitialState(): AppState {
  return {
    summaries: []
  };
}

@Injectable()
export class AppStore extends Store<AppState> {
  constructor(protected dispatcher: AppDispatcher) {
    super(getInitialState(), dispatcher);
  }
  get appState(): Observable<AppState> {
    return this.observable.map<AppState>(s => s);
  }
  get dayOfWeekSummaries(): Observable<IDayOfWeekSummaries> {
    return this.observable.map<IDayOfWeekSummaries>(s => {
      if (s.summaries.length === 0) return;

      return Array.from(new Set(s.summaries.map(d => d.date)))
        .map(date => {
          const summaries = s.summaries
            .filter(d => d.date === date)
            .reduce<IResSummary[]>((p, c) => [...p, c], []);
          return { date, summaries };
        });
    });
  }
}

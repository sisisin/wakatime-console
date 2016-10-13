import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Store } from 'walts';

import { AppState, IResSummary, IDayOfSummaries } from './app.state';
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
  get dayOfSummaries(): Observable<IDayOfSummaries> {
    return this.observable.map<IDayOfSummaries>(s => {
      const d = s.summaries.reduce((prev, curr, i) => {
        const newValue = prev[curr.date] ? [...prev[curr.date], curr] : [curr];
        return Object.assign({}, prev, { [curr.date]: newValue });
      }, <{ [key: string]: IResSummary[] }>{});
      return d;
    })
  }
}

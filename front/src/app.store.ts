import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Store } from 'walts';
import * as moment from 'moment';
import { AppState, IResSummary, IDayOfWeekSummaries, IDailySummaries } from './app.state';
import { AppDispatcher } from './app.dispatcher';

function getInitialState(): AppState {
  return {
    summaries: []
  };
}
const beforeWeek = moment().startOf('date').add(-7, 'day');
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

      const d = Array(7).fill(0)
        .map((_, i) => {
          const date = beforeWeek.clone().add(i, 'day').toDate();
          const summaries = s.summaries
            .map(s => Object.assign({}, s, { date: moment(s.date).startOf('date').toDate() }))
            .filter(d => d.date.getTime() === date.getTime())
            .reduce((p, c) => [...p, c], []);

          return <IDailySummaries>{ date, summaries };
        });
      return d;
    });
  }
}

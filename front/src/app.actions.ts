import { Injectable } from '@angular/core';
import { Actions, Action } from 'walts';

import { AppState } from './app.state';

@Injectable()
export class AppActions extends Actions<AppState> {
  fetchSummaries(): Action<AppState> {
    return () => {
      return fetch('/api/v1/summaries')
        .then(res => res.json())
        .then(json => {
          console.log(json);
          return (state: AppState) => Object.assign({}, state, json);
        });
    }
  }
}

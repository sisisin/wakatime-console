import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Store } from 'walts';

import { AppState } from './app.state';
import { AppDispatcher } from './app.dispatcher';

function getInitialState(): AppState {
  return {};
}

@Injectable()
export class AppStore extends Store<AppState> {
  constructor(protected dispatcher: AppDispatcher) {
    super(getInitialState(), dispatcher);
  }
  get appState(): Observable<AppState> {
    return this.observable.map<AppState>(s => s);
  }
}

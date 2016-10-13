import { Component } from '@angular/core';
import { AppActions } from '../app.actions';
import { AppDispatcher } from '../app.dispatcher';
import { AppStore } from '../app.store';
import { AppState, IDayOfSummaries } from '../app.state';

@Component({
  selector: 'my-app',
  template: `
    <h1>dashboard</h1>
    <my-weekly [summaries]="dayOfSummaries"></my-weekly>
  `
})
export class AppComponent {
  private state: AppState;
  private dayOfSummaries: IDayOfSummaries;
  constructor(
    private store: AppStore,
    private dispatcher: AppDispatcher,
    private action: AppActions
  ) { }
  ngOnInit() {
    this.store.appState.subscribe(s => {
      this.state = s;
    });
    this.store.dayOfSummaries.subscribe(s => this.dayOfSummaries = s);
    this.dispatcher.emit(this.action.fetchSummaries());
  }
}

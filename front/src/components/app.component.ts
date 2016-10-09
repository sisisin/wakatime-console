import { Component } from '@angular/core';
import { AppActions } from '../app.actions';
import { AppDispatcher } from '../app.dispatcher';
import { AppStore } from '../app.store';
import { AppState } from '../app.state';

@Component({
  selector: 'my-app',
  template: `
    <h1>dashboard</h1>
    <div *ngIf="state">
      <div>{{state.name}}</div>
      <div>{{state.date}}</div>
      <div>{{state.total_seconds}}</div>
    </div>
  `
})
export class AppComponent {
  private state: AppState;
  constructor(
    private store: AppStore,
    private dispatcher: AppDispatcher,
    private action: AppActions
  ) { }
  ngOnInit() {
    this.store.appState.subscribe(s => {
      this.state = s
    });
    this.dispatcher.emit(this.action.fetchSummaries());
  }
}

import { Component } from '@angular/core';
import { AppActions } from '../app.actions';
import { AppDispatcher } from '../app.dispatcher';
import { AppStore } from '../app.store';
import { AppState } from '../app.state';

@Component({
  selector: 'my-app',
  template: `
    <div>hogeee</div>
  `
})
export class AppComponent {
  private state: AppState;
  constructor(
    private store: AppStore
  ) { }
  ngOnInit() {
    this.store.appState.subscribe(s => {
      this.state = s
    });
  }
}

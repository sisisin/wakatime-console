import { Component, Input } from '@angular/core';
import { AppActions } from '../app.actions';
import { AppDispatcher } from '../app.dispatcher';
import { IResSummary, IDayOfSummaries } from '../app.state';

@Component({
  selector: 'my-weekly',
  template: `
    <h2>weekly activity</h2>
    <div *ngFor="let date of keys">
      {{date}} : {{getSumSecounds(date)}}
    </div>
  `
})
export class WeeklyComponent {
  @Input() summaries: IDayOfSummaries;

  get keys(): string[] {
    return Object.keys(this.summaries);
  }
  getSumSecounds(key: string): number {
    return this.summaries[key].reduce((prev, curr) => prev + curr.total_seconds, 0);
  }
}

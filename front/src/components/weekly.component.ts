import { Component, Input } from '@angular/core';
import { AppActions } from '../app.actions';
import { AppDispatcher } from '../app.dispatcher';
import { IResSummary, IDayOfSummaries } from '../app.state';

@Component({
  selector: 'my-weekly',
  template: `
  <div style="display: block;width:800px;height:400px;" *ngIf="summaries">
    <canvas baseChart
      [datasets]="datasets"
      [labels]="labels"
      [options]="options"
      [colors]="colors"
      [legend]="legend"
      [chartType]="chartType">
    </canvas>
  </div>
`
})
export class WeeklyComponent {
  @Input() summaries: IDayOfSummaries;
  get datasets() {
    const data = this.keys.map(key => this.summaries[key].reduce((prev, curr) => prev + curr.total_seconds, 0));
    return [{ data, label: 'total sec', lineTension: 0.2 }];
  }
  get labels() {
    return this.keys;
  }
  public options = {
    animation: false,
    responsive: true
  };
  public colors = [{
    backgroundColor: 'rgba(77,83,96,0.2)',
    borderColor: 'rgba(77,83,96,1)',
    pointBackgroundColor: 'rgba(77,83,96,1)',
    pointBorderColor: '#fff',
    pointHoverBackgroundColor: '#fff',
    pointHoverBorderColor: 'rgba(77,83,96,1)'
  }];
  public legend = true;
  public chartType: string = 'line';
  get keys(): string[] {
    return Object.keys(this.summaries);
  }
}

import { Component, Input } from '@angular/core';
import * as moment from 'moment';
import { AppActions } from '../app.actions';
import { AppDispatcher } from '../app.dispatcher';
import { IResSummary, IDayOfWeekSummaries } from '../app.state';

const dayToString = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

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
  @Input() summaries: IDayOfWeekSummaries;
  get datasets() {
    const data = this.summaries.map(s => s.summaries.reduce((p, c) => p + c.total_seconds, 0));
    return [{ data, label: 'total sec', lineTension: 0.2 }];
  }
  get labels() {
    return this.summaries.map(s => `${dayToString[s.date.getDay()]}. ${s.date.getMonth() + 1}-${s.date.getDate()}`);
  }
  public options = {
    animation: false,
    responsive: true,
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true,
          stepSize: 60 * 60 * 0.5,
          callback(value: number) {
            return moment.duration(value, 'seconds').asHours().toString().slice(0, 3) + ' hr';
          }
        }
      }]
    }
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
}

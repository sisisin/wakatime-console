import { Component, OnInit } from '@angular/core';
import 'rxjs/add/operator/filter';

import { SummariesService } from './services/summaries.service';
import { ISummaries } from './models/summaries';

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
    title = 'app';
    weeklySummary: string;
    constructor(private summariesService: SummariesService) { }

    ngOnInit() {
        this.summariesService.list().subscribe(res => {
            const body = <ISummaries[]>res.json();
            const z = new Date(0);
            const w = new Date(0);
            w.setSeconds(z.getSeconds() + body.reduce((prev, curr) => prev + curr.totalSeconds, 0))
            this.weeklySummary = `${w.getHours() - z.getHours()}h ${w.getMinutes()}m`
        });
    }
}

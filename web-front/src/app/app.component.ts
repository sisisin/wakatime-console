import { Component, OnInit, Inject } from '@angular/core';
import { Http } from '@angular/http';

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
    title = 'app';
    constructor(private http: Http, @Inject('HOST') private host: string) { }

    ngOnInit() {
        this.http.get(`${this.host}/api/summaries`).subscribe(res => {
            const body = res.json();
            console.log(body);
        })
    }
}

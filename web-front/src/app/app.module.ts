import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';

import { environment } from '../environments/environment';
import { AppComponent } from './app.component';
import { SummariesService } from './services/summaries.service';
import { HttpClientService } from './services/http-client.service';

@NgModule({
    declarations: [
        AppComponent
    ],
    imports: [
        BrowserModule, HttpModule
    ],
    providers: [
        { provide: 'HOST', useValue: environment.host },
        SummariesService,
        HttpClientService
    ],
    bootstrap: [AppComponent]
})
export class AppModule { }

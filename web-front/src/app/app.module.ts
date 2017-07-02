import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';

import { environment } from '../environments/environment';
import { AppComponent } from './app.component';

@NgModule({
    declarations: [
        AppComponent
    ],
    imports: [
        BrowserModule, HttpModule
    ],
    providers: [{ provide: 'HOST', useValue: environment.host }],
    bootstrap: [AppComponent]
})
export class AppModule { }

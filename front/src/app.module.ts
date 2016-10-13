import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppComponent } from './components/app.component';
import { WeeklyComponent } from './components/weekly.component'
import { AppActions } from './app.actions';
import { AppDispatcher } from './app.dispatcher';
import { AppStore } from './app.store';
import { AppState } from './app.state';

@NgModule({
  imports: [
    BrowserModule
  ],
  declarations: [
    AppComponent,
    WeeklyComponent
  ],
  providers: [
    AppActions,
    AppDispatcher,
    AppStore
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }

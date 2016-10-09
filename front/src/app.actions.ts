import { Injectable } from '@angular/core';
import { Actions, Action } from 'walts';

import { AppState } from './app.state';

@Injectable()
export class AppActions extends Actions<AppState> { }

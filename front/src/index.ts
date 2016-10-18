import 'core-js';
import 'zone.js/dist/zone';

import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { AppModule } from './app.module';

declare var require: any;
const Chart: any = require('../../node_modules/chart.js/src/chart');

// for sprockets
// (<any>window).runNg2 = () => 
platformBrowserDynamic().bootstrapModule(AppModule)

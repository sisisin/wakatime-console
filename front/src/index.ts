import 'core-js';
import 'zone.js/dist/zone';

import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { AppModule } from './app.module';

// for sprockets
(<any>window).runNg2 = () => platformBrowserDynamic().bootstrapModule(AppModule)

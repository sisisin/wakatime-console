import { Injectable } from '@angular/core';
import { HttpClientService } from './http-client.service';

@Injectable()
export class SummariesService {
    constructor(private httpClient: HttpClientService) { }

    list() {
        return this.httpClient.get('/api/summaries');
    }
}

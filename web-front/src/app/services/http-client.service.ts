import { Injectable, Inject } from '@angular/core';
import { Http, RequestOptionsArgs } from '@angular/http';

@Injectable()
export class HttpClientService {
    constructor(private http: Http, @Inject('HOST') private host: string) { }

    get(url: string, options?: RequestOptionsArgs) {
        return this.http.get(`${this.host}${url}`, options).filter(res => res.status === 200);
    }

    post(url: string, body: any, options?: RequestOptionsArgs) {
        return this.http.post(`${this.host}${url}`, body, options);
    }
}

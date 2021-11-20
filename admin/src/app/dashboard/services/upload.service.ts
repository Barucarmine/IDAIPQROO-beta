import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';


const base_url = environment.base_url;

@Injectable({
  providedIn: 'root'
})
export class UploadService {

  constructor(private http: HttpClient ) { }

  uploadImage( tipo: 'users'|'news'|'tips'|'institutes'|'reports', archivo: File,  id: string  ): Observable<any>{
    const url = `${ base_url }/upload/${tipo}/${ id }`;
    const formData: FormData = new FormData();
    formData.append('image', archivo, archivo.name );
    return this.http.put( url, formData, { reportProgress: true } )
              .pipe(
                catchError( error => of(false) )
              );

  }


}

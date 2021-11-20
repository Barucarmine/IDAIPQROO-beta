import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, of } from 'rxjs';
import { User } from '../../models/user.model';
import { catchError, map, tap } from 'rxjs/operators';
import { environment } from '../../../environments/environment';
import { LoginForm } from '../interfaces/login-form.interface';

const base_url = environment.base_url;

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  public user!: User;
 
  constructor( private http: HttpClient,
               private router: Router,/* 
               private wsService: WebSocketService  */) { }


  get token(): string { 
    return localStorage.getItem('accessToken') || '';
  }




  validarToken(): Observable<boolean> {

    return this.http.get(`${ base_url }/auth/renew`)
    .pipe(
      tap( (resp: any) => {
        localStorage.setItem('accessToken', resp.accessToken );
        // localStorage.setItem('menu', JSON.stringify(resp.menu) );
        const { 
          _id,
          name,
          email,
          role,
          online,
          description,
          image,
          institute,

        } = resp.user;
        this.user = new User(name, email, image, role, online, description, _id, '', institute );
        console.log(this.user)
      }),
      map( resp => true ),
      catchError( error => of(false) )
    );
  }



  isAdminRole(): boolean{

    console.log('Se ejecutro')
    if ( this.user.role == 'ADMIN_ROLE' ){
      return true
    }
    return false
    
  }



  login( formData: LoginForm ): Observable<any>{
    return this.http.post(`${ base_url }/auth/login`, formData )
                  .pipe(
                    tap( (resp: any) => {
                      const { 
                        _id,
                        name,
                        email,
                        role,
                        online,
                        description,
                        image,
                        institute,
              
                      } = resp.user;
                      this.user = new User(name, email, image, role, online, description, _id, '', institute );
                      
                      localStorage.setItem('accessToken', resp.accessToken );
                      // localStorage.setItem('menu', JSON.stringify(resp.menu) );
                    })
                  );
  }


  /* register( formData: RegisterForm ): Observable<any>{
    return this.http.post(`${ base_url }/auth/register`, formData );
  } */


  logout(): void {
    localStorage.removeItem('accessToken');
    // localStorage.removeItem('menu');
    this.router.navigateByUrl('auth/login');
  }




  getAllUsers() {
    return this.http.get(`${ base_url }/user/user` )
  }


}

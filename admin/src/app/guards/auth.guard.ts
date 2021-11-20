import { Injectable } from '@angular/core';
import { CanActivate, CanLoad, Route, UrlSegment, ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';
import { AuthService } from '../auth/services/auth.service';
import { SocketService } from '../socket/socket.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate, CanLoad {

  constructor( private authService: AuthService,
               private socketService: SocketService,
               private router: Router ){}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean> | boolean{

    return this.authService.validarToken()
      .pipe(
        tap( estaAutenticado => {
          this.socketService.connect();
          if (!estaAutenticado) {
            this.router.navigate(['./auth/login']);
            }
        })      
      );
    
      /* if ( this.authService.auth.id ) {
        return true;
      }
  
      console.log('Bloqueado con el AuthGuard - CanActivate');
      return false; */
  }


  canLoad(
    route: Route,
    segments: UrlSegment[]): Observable<boolean> | boolean {
    
    
    
    return this.authService.validarToken()
      .pipe(
        tap( estaAutenticado => {
          this.socketService.connect();
          if (!estaAutenticado) {
            this.router.navigate(['./auth/login']);
            }
        })      
    ); 
    
    /* if ( this.authService.auth.id ) {
      return true;
    }
    console.log('Bloqueado con el AuthGuard - CanLoad');
    return false; */
  }
}
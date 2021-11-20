import { Injectable } from '@angular/core';
import { CanActivate, CanLoad, Route, UrlSegment, ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';
import { AuthService } from '../auth/services/auth.service';
import { SocketService } from '../socket/socket.service';

@Injectable({
  providedIn: 'root'
})
export class AdminRoleGuard implements CanActivate {

  constructor( private authService: AuthService,
               private socketService: SocketService,
               private router: Router ){}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean> | boolean{

      if ( this.authService.isAdminRole() ) {
        return true
      }
      this.router.navigate(['./my-reports-pendientes']);
      return false
    
  }


  
}
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import Swal from 'sweetalert2';
import { AuthService } from '../../services/auth.service';
import { SocketService } from '../../../socket/socket.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  public formSubmitted = false;

  public loginForm: FormGroup = this.fb.group({
    email: [ localStorage.getItem('email') || '', [ Validators.required ] ],
    password: ['', [ Validators.required, Validators.minLength(6) ] ],
    remember: [ false ]
  });

  constructor( private fb: FormBuilder,
               private authService: AuthService,
               private socketService: SocketService,
               private router: Router ) { }

  ngOnInit(): void {
  }


  login(): void {

    if ( this.loginForm.invalid ) { return; }

    this.formSubmitted = true;


    this.authService.login( this.loginForm.value )
          .subscribe( () => {

            if ( this.loginForm.get('remember')?.value ){
              localStorage.setItem('email', this.loginForm.get('email')?.value );
            } else {
              localStorage.removeItem('email');
            }

            this.socketService.connect();

            if ( this.authService.user.role == 'ADMIN_ROLE' ){
              this.router.navigateByUrl('/reports');
            } else {
              this.router.navigateByUrl('/my-reports-pendientes');
            }



          }, err => {
              Swal.fire({
                title: 'Error',
                text: err.error.message,
                icon: 'error'
              });
              console.log(err)
          });

  }


  campoNoValido( campo: string ): boolean {


    if ( this.loginForm.get(campo)?.invalid && this.formSubmitted ) {
      return true;
    } else {
      return false;
    }

  }


  mensajesError( campo: string  ): string {

    return this.loginForm.get(campo)?.hasError('required') ? `Este campo es requerido.` :
           this.loginForm.get(campo)?.hasError('minlength') ? `Mínimo 6 caracteres.` : '';
  }


}

import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../auth/services/auth.service';
import { User } from '../../../models/user.model';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css']
})
export class ChatComponent implements OnInit {

  users: User[] = [];
  userSelected?: User;

  constructor( private authService: AuthService ) { }

  ngOnInit(): void {
    this.authService.getAllUsers()
      .subscribe( (resp: any) => {
        this.users = resp.users
        
      })
  }


  asignarUser( user: User){
    this.userSelected = user;
  }

}

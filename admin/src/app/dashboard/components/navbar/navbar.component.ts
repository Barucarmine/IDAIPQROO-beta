import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../auth/services/auth.service';
import { SocketService } from '../../../socket/socket.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {

  constructor( public authService: AuthService,
               private socketService: SocketService) { }

  ngOnInit(): void {
  }


  logout() {
    this.authService.logout()
    this.socketService.disconnect()
  }

}

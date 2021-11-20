import { Component, OnInit, Input, OnChanges } from '@angular/core';
import { User } from '../../models/user.model';
import { ChatService } from '../services/chat.service';
import { AuthService } from '../../auth/services/auth.service';
import { SocketService } from '../../socket/socket.service';

@Component({
  selector: 'app-chat-container',
  templateUrl: './chat-container.component.html',
  styleUrls: ['./chat-container.component.css']
})
export class ChatContainerComponent implements OnInit, OnChanges {

  @Input() user!: User;
  messages: any[] = []

  constructor( private chatService: ChatService,
               private authService: AuthService,
              private socketService: SocketService) { }

  ngOnInit(): void {
    this.socketService.socket!.on('personal-message', ( payload: any) => {
      this.messages.push(payload)
    });
  }

  ngOnChanges(): void {
    console.log('cambio', this.user!.name)
    this.chatService.getMessages( this.user!._id )
        .subscribe( (resp: any) => {
          this.messages = resp.messages.reverse()
          console.log(this.messages)
        })
        
    
  }

  listenMessage( payload: any) {
    console.log(this.messages)
    console.log(payload)
    console.log(this.user)
    // this.messages.push(payload)
  }


  enviar( text: any ){

    if ( text.length == 0 ) return;

    const message = {
      from: this.authService.user._id,
      to: this.user._id,
      message: text,
    }

    this.messages.push( message )


    this.socketService.socket!.emit('personal-message', message );

  }

}

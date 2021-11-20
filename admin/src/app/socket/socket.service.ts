import { Injectable } from '@angular/core';
import io, { Socket } from 'socket.io-client';
import { environment } from '../../environments/environment';

const ws_url = environment.ws_url;


@Injectable({
  providedIn: 'root'
})
export class SocketService {

   socket?: Socket;
  public socketStatus: boolean = false;

  constructor(  ) { }

  connect(){
    const token = localStorage.getItem('accessToken')

    this.socket = io( ws_url , 
      { 
        transports: ["websocket"],
        forceNew: true,
        query: {
          'accessToken': `Bearer ${token}`
        }
      }
    )

    this.checkStatus();

  }


  checkStatus() {

    this.socket!.on('connect', () => {
      console.log('Conectado al servidor');
      this.socketStatus = true;
    });

    this.socket!.on('disconnect', () => {
      console.log('Desconectado del servidor');
      this.socketStatus = false;
    });
  }

  disconnect() {
    this.socket!.disconnect();
  }

  

}

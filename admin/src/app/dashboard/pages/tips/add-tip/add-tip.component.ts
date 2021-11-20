import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { mergeMap, switchMap, tap } from 'rxjs/operators';
import { TipsService } from 'src/app/dashboard/services/tips.service';

import { Tip } from 'src/app/models/tip.model';
import Swal from 'sweetalert2';
import { UploadService } from '../../../services/upload.service';

@Component({
  selector: 'app-add-tip',
  templateUrl: './add-tip.component.html',
  styleUrls: ['./add-tip.component.css']
})
export class AddTipComponent implements OnInit {

  title = 'Agrega Nuevos Datos/Tips Interesantes';
  tip: Tip = new Tip('','','',true,);
  

  archivoSubir!: File | null;
  archivoTemporal: any;
  isLoading: boolean = true;


  constructor( public router: Router,
               private activatedRoute: ActivatedRoute,
               private tipsService: TipsService,
               private uploadService: UploadService ) { }
  
  ngOnInit(): void {

    if ( !this.router.url.includes('edit') ) { return; }

    this.activatedRoute.params
        .pipe(
          switchMap( ({id}) => this.tipsService.getById(id) )
        )
        .subscribe( (resp: any) => {
          this.tip = resp.tip  
        });


  }


  async guardar( ) { 
    


    if ( !this.tip._id ){

      const { isConfirmed } = await Swal.fire({
          title: '¿Esta seguro?.',
          text: 'Se creará una nueva Dato/Tip',
          icon: 'info',
          showCancelButton: true,
          confirmButtonText: 'Si!',
          cancelButtonText: 'No, cancelar!',
          showCloseButton: true,
      })

      if ( !isConfirmed ){
        return
      }

      this.tipsService.create( this.tip )
        .subscribe( ( resp: any) => {

      //      this.router.navigate(['/tip/edit', resp._id ]  );

            Swal.fire({
              icon: 'success',
              title: 'Guardado.',
              text: `Tip creado con éxito.`
            }) 
        })

    } else {
      console.log('EDITAR')
    }


  }



  changeFile( target: any ): void {

    const file = target.files[0] 

    this.archivoSubir = file

    if ( !file ) {
      this.archivoSubir = null;
    }


    const reader = new FileReader();
    reader.readAsDataURL( file );


    reader.onloadend = () => {
      this.archivoTemporal = reader.result;
    }


  }



  uploadImage(): void {

    this.uploadService.uploadImage( 'tips', this.archivoSubir!, this.tip._id! )
      .subscribe( ({message, nombreFoto}) => {
        this.tip.image = nombreFoto
        Swal.fire({
          icon: 'success',
          title: 'Éxito',
          text: 'Imagen actualizada con éxito.'
        })
      }, (err) => {
        Swal.fire({
          icon: 'error',
          title: 'Oops!',
          text: 'Ocurrio un error. Hable con el administrador.'
        })
      })

  }

}

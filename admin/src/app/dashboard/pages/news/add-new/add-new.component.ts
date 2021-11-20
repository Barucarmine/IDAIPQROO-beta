import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { mergeMap, switchMap, tap } from 'rxjs/operators';
import { Novedad } from 'src/app/models/novedad.model';
import { NewsService } from 'src/app/dashboard/services/news.service';
import Swal from 'sweetalert2';
import { UploadService } from '../../../services/upload.service';


@Component({
  selector: 'app-add-new',
  templateUrl: './add-new.component.html',
  styleUrls: ['./add-new.component.css']
})
export class AddNewComponent implements OnInit {

  title = 'Agrega Novedades';
  new: Novedad = new Novedad('','','',true,);

  archivoSubir!: File | null;
  archivoTemporal: any;
  isLoading: boolean = true;

  constructor(public router: Router,
    private activatedRoute: ActivatedRoute,
    private newsService: NewsService,
    private uploadService: UploadService) { }

  ngOnInit(): void {
    if ( !this.router.url.includes('edit') ) { return; }

    this.activatedRoute.params
        .pipe(
          switchMap( ({id}) => this.newsService.getById(id) )
        )
        .subscribe( (resp: any) => {
          this.new = resp.new  
        });
  }

  async guardar( ) { 
    


    if ( !this.new._id ){

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

      this.newsService.create( this.new )
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

    this.uploadService.uploadImage( 'news', this.archivoSubir!, this.new._id! )
      .subscribe( ({message, nombreFoto}) => {
        this.new.image = nombreFoto
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

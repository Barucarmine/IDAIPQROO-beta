import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { mergeMap, switchMap, tap } from 'rxjs/operators';
import { InstitutesService } from 'src/app/dashboard/services/institutes.service';
import { MunicipalitiesService } from 'src/app/dashboard/services/municipalities.service';

import { Institute } from 'src/app/models/institute.model';
import Swal from 'sweetalert2';
import { UploadService } from '../../../services/upload.service';

@Component({
  selector: 'app-add-institute',
  templateUrl: './add-institute.component.html',
  styleUrls: ['./add-institute.component.css']
})
export class AddInstituteComponent implements OnInit {

  title = 'Agregar Institución';
  institute: Institute = new Institute('','','','', '');
  form = {
    email: '',
    password: ''
  }
  municipalities: [] = []

  archivoSubir!: File | null;
  archivoTemporal: any;
  isLoading: boolean = true;


  constructor( public router: Router,
               private activatedRoute: ActivatedRoute,
               private institutesService: InstitutesService,
               private municipalitiesService: MunicipalitiesService,
               private uploadService: UploadService ) { }
  
  ngOnInit(): void {

    this.municipalitiesService.getMunicipalities()
        .subscribe( municipalities => this.municipalities = municipalities )

    if ( !this.router.url.includes('edit') ) { return; }

    this.activatedRoute.params
        .pipe(
          switchMap( ({id}) => this.institutesService.getById(id) )
        )
        .subscribe( (resp: any) => {
          this.institute = resp.institute 
          this.title = resp.institute.name 
        });


  }


  async guardar( ) {


    if ( !this.institute._id ){

      const { isConfirmed } = await Swal.fire({
          title: '¿Esta seguro?.',
          text: 'Se creará una nueva institución',
          icon: 'info',
          showCancelButton: true,
          confirmButtonText: 'Si!',
          cancelButtonText: 'No, cancelar!',
          showCloseButton: true,
      })

      if ( !isConfirmed ){
        return
      }

      this.institutesService.create( this.institute )
        .pipe(
          tap( institute => this.institute = institute ),
          mergeMap( ({ name, _id }) => this.institutesService.adduser({
            ...this.form,
            name,
            role: 'INSTITUTE_ROLE',
            institute: _id
          }))
        ).subscribe( ( resp: any) => {

            this.router.navigate(['/institute/edit', resp.user.institute ]  );

            Swal.fire({
              icon: 'success',
              title: 'Guardado.',
              text: `${ resp.user.name } creado con éxito.`
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

    this.uploadService.uploadImage( 'institutes', this.archivoSubir!, this.institute._id! )
      .subscribe( ({message, nombreFoto}) => {
        this.institute.image = nombreFoto
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

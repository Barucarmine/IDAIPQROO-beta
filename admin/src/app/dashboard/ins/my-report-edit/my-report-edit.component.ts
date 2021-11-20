import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Service } from '../../../models/service.model';
import { ReportsService } from '../../services/reports.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-my-report-edit',
  templateUrl: './my-report-edit.component.html',
  styleUrls: ['./my-report-edit.component.css']
})
export class MyReportEditComponent implements OnInit {

  public formSubmitted = false;

  public myForm: FormGroup = this.fb.group({
    status: [ '', [ Validators.required ] ],
    observations: [ '', [ Validators.required ] ],
  });


  service!: Service;

  constructor( private activatedRoute: ActivatedRoute,
               private reportsService: ReportsService,
               private fb: FormBuilder ) { }

  ngOnInit(): void {

    this.activatedRoute.params.subscribe( ({id}) => {
        this.reportsService.getServiceById(id)
            .subscribe( (resp: any) => {
              this.service = resp.service
              console.log(resp)
            })
    })

  }


  actualizar() {

    if ( this.myForm.invalid ) { return; }
    
    this.formSubmitted = true;
 

    Swal.fire({
      icon: "question",
      title: '¿Esta seguro?',
      showCancelButton: true,
      confirmButtonColor: '#86134F',
      confirmButtonText: 'Si!',
      cancelButtonText: 'No, cancelar!',
      showCloseButton: true,
    }).then((result) => {
      if (result.isConfirmed) {

        this.reportsService.updateStatus( this.service._id!, this.myForm.value )
            .subscribe( (resp: any) => {

              Swal.fire({
                icon: 'success',
                title: 'Éxito',
                text: 'El reporte se ha asignado con éxito a la Institución correspondiente.'
              })

            }, err => {
              Swal.fire({
                icon: 'error',
                title: 'Oops!',
                text: err.error.message
              })
            })

      }
    })

    this.formSubmitted = false;


  }

}

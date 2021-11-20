import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Report } from 'src/app/models/report.model';
import { ReportsService } from '../../../services/reports.service';
import Swal from 'sweetalert2';
import { Institute } from '../../../../models/institute.model';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-asignar-report',
  templateUrl: './asignar-report.component.html',
  styleUrls: ['./asignar-report.component.css']
})
export class AsignarReportComponent implements OnInit {

  report!: Report;
  institutes: Institute[] = [];

  public formSubmitted = false;

  public myForm: FormGroup = this.fb.group({
    institute: ['', [ Validators.required ] ]
  });

  constructor( private fb: FormBuilder,
              private reportService: ReportsService,
              private activateRouter: ActivatedRoute,) { }

  ngOnInit(): void {
    this.activateRouter.params.subscribe(({id}) => {
      
      this.reportService.getReportNotAssigned( id )
          .subscribe( (resp: any) => {
            this.report = resp.report;

            this.reportService.getInstitutesByMunicipality( resp.report.municipality)
              .subscribe( (resp: any) => {
                this.institutes = resp.institutes
              })

          })

    })


  } 



  asignar() {

    if ( this.myForm.invalid ) { return; }
    
    this.formSubmitted = true;


    console.log(this.myForm.value)


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

        const { institute } = this.myForm.value
        this.reportService.asignar( this.report._id!, institute )
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

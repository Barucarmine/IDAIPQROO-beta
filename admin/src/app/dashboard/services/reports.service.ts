import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { map } from 'rxjs/operators';
import { Report } from '../../models/report.model';
import { ReportsReponse } from '../interfaces/reports_response.interface';
import { ServicesReponse } from '../interfaces/services_response.interface';
import { Service } from '../../models/service.model';

const base_url = environment.base_url;

@Injectable({
  providedIn: 'root'
})
export class ReportsService {

  constructor( private http: HttpClient ) { }


  getCategories( ) {
    return this.http.get(`${base_url}/category/all`)
      .pipe(
        map(  (resp: any) => {
          return resp.categories;
        })
      );
  
  }

  getReportNotAssigned( idReport: string ){   
    return this.http.get<ReportsReponse>(`${base_url}/report/notassignedById/${ idReport }`)
  }

  getReportsNotAssigned(){
    return this.http.get<ReportsReponse>(`${base_url}/report/allnotassigned`)
      .pipe(
        map(  resp => {
          const reports = resp.reports.map(
              report => new Report(
              report.user,
              report.title,
              report.category,
              report.description,
              report.municipality,
              report.colony,
              report.anonymous,
              report.assigned,
              report.image,
              report.createdAt,
              report.location,
              report.updatedAt,
              report._id
            )
          );
          return reports;
        })
      );
  }


  getByCategoryAndStatus( status: string, category: string){
    return this.http.get<ServicesReponse>(`${base_url}/service/all/${status}/${category}`)
      .pipe(
        map(  resp => {
          const services = resp.services.map(
              service => new Service(
                service.report,
                service.institute,
                service.observations,
                service.contributions,
                service.status,
                service.qualification,
                service._id,
            )
          );
          return services;
        })
      );
  }


  asignar( reportId: string, instituteId: string ){
    return this.http.get(`${base_url}/report/assign/${reportId}/${instituteId}`)
  }




  /* INSTITUTE */
  getInstitutesByMunicipality( municipality: string ){
    return this.http.get(`${base_url}/institute/all/${municipality}`)
  }


  getEstadisticasPorMunicipio( municipio: string ){
    return this.http.get(`${base_url}/report/estadisticas/${municipio}`)
  }



  getMyReportsPendientes( idInstitucion: string, status: string  ) {
    return this.http.get(`${base_url}/service/institute/${ status }/${ idInstitucion }`)
  }



  getServiceById( id: string ) {
    return this.http.get(`${base_url}/service/id/${ id }`)
  }



  updateStatus( id: string, data: {} ){
    return this.http.put(`${base_url}/service/id/${id}`, data)
  }

}

import { Report } from '../../models/report.model';


export interface ReportsReponse {

    status: boolean;
    reports: Report[];

}
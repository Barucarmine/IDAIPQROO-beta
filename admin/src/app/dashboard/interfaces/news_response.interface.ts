import { Novedad } from '../../models/novedad.model';



export interface NewsResponse {

    status: boolean;
    news: Novedad[];

}
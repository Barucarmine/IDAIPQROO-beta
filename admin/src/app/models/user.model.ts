import { environment } from '../../environments/environment';
import { Institute } from './institute.model';

const base_url = environment.base_url;

export class User {

    constructor(
        public name: string,
        public email: string,
        public image: string,
        public role?: 'ADMIN_ROLE' | 'USER_ROLE',
        public online?: boolean,
        public description?: string,
        public _id?: string,
        public password?: string,
        public institute?: string,
    ){}

    get imageUrl(): string {
        if ( this.image ) {
            return `${ base_url }/upload/users/${ this.image }`;
        } else {
            return `${ base_url }/upload/no-image/no-image`;
        }
    }

}
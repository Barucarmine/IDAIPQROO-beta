import { User } from './user.model';


export class Report {

    constructor(
        public user: User,
        public title: string,
        public category: string,
        public description: string,
        public municipality: string,
        public colony: string,
        public anonymous: boolean,
        public assigned: boolean,
        public image?: string,
        public createdAt?: string,
        public location?: {},
        public updatedAt?: string,
        public _id?: string,
    ){}



}
import { Report } from "./report.model";
import { Institute } from './institute.model';



export class Service {

    constructor(
        public report: Report,
        public institute: Institute,
        public observations: string,
        public contributions: number,
        public status: 'FINALIZED' | 'CANCELLED' | 'PROCESS' | 'PENDING',
        public qualification?: {},
        public _id?: string,
    ){}

}
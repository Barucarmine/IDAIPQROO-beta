import { Tip } from '../../models/tip.model';


export interface TipsReponse {

    status: boolean;
    tips: Tip[];

}
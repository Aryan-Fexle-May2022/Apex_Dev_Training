import { api, LightningElement } from 'lwc';

export default class LdsRecordFormViewLwc extends LightningElement {
    @api recordId;
    @api objectApiName;
}
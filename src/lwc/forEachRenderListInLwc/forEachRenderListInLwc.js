import { api, LightningElement, wire } from 'lwc';
import FORM_OBJECT from '@salesforce/schema/Form__c';
import { getListUi } from 'lightning/uiListApi';
export default class ForEachRenderListInLwc extends LightningElement {
    @api objectApiName;
    @api recordId;
    forms;
    areDetailsVisible = false;
    @wire(getListUi,
        {
            objectApiName: FORM_OBJECT,
            listViewApiName: 'All'
        }) wiredListView({ data, error }) {
            if (data) {
                this.forms = data.records.records;
            }
        };
    handleChange(event) {
        this.areDetailsVisible = event.target.checked;
    }
}
import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import FORM_OBJECT from '@salesforce/schema/Form__c';
export default class GetListUiAdapter extends LightningElement {
    formResults;
    @wire(getListUi, {
        objectApiName: FORM_OBJECT,
        listViewApiName: 'All'
    }) wiredListView({ data, error }) {
        if (data) {
            console.log(`Data : ${data}`);
            console.log(`Data.record : ${data.records}`);
            console.log(`Data.record.record : ${data.records.records}`);
            this.formResults = data.records.records;
        }
        else {
            console.log('Error : ' + error);
        }
    }
}
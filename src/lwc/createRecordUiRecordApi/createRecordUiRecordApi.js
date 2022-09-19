import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import FORM_OBJECT from '@salesforce/schema/Form__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Form__c.Name';
import FIRST_NAME_FIELD from '@salesforce/schema/Form__c.First_Name__c';
import LAST_NAME_FIELD from '@salesforce/schema/Form__c.Last_Name__c';
import PHONE_NUMBER_FIELD from '@salesforce/schema/Form__c.Phone_Number__c';
import ADDRESS_FIELD from '@salesforce/schema/Form__c.Address__c';

export default class CreateRecordUiRecordApi extends LightningElement {
    formFields = {
        Name: '',
        First_Name: '',
        Last_Name: '',
        Phone_Number: '',
        Address: ''
    };
    changeHandler(event) {
        const { value, name } = event.target;
        this.formFields = { ...this.formFields, [name]: value };
    }
    handleSave() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.formFields.Name;
        fields[FIRST_NAME_FIELD.fieldApiName] = this.formFields.First_Name;
        fields[LAST_NAME_FIELD.fieldApiName] = this.formFields.Last_Name;
        fields[PHONE_NUMBER_FIELD.fieldApiName] = this.formFields.Phone_Number;
        fields[ADDRESS_FIELD.fieldApiName] = this.formFields.Address;
        let recordInput = { apiName: FORM_OBJECT.objectApiName, fields };
        createRecord(recordInput).then(result => {
            this.formFields = {};
            const event = new ShowToastEvent({
                title: 'Form Submitted',
                message: "Thank You!",
                variant: 'success'
            });
            this.dispatchEvent(event);
            console.log('FORM Account Created Id :>> ', JSON.stringify(result.id));
        }).catch(error => {
            const event = new ShowToastEvent({
                title: 'Form Cannot be Submitted',
                message: "Sorry, Thank You!",
                variant: 'error'
            });
            console.log('ERROR : ', error);
        });
    }
}
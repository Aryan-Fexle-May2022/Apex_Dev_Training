/*
    Record form (Default form) is a Lightning Data Service component used to 
    create a Save and Editable form.
    Or Created an editable form or display form for a record.
*/
import { api, LightningElement } from 'lwc';
import FORM_NAME from "@salesforce/schema/Form__c.Name";
import FIRST_NAME from "@salesforce/schema/Form__c.First_Name__c";
import LAST_NAME from "@salesforce/schema/Form__c.Last_Name__c";
import PHONE_NUMBER from "@salesforce/schema/Form__c.Phone_Number__c";
import ADDRESS from "@salesforce/schema/Form__c.Address__c";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class RecordFormLwc extends LightningElement {
    fields = [FORM_NAME, FIRST_NAME, LAST_NAME, PHONE_NUMBER, ADDRESS];
    @api objectApiName;
    @api recordId;
    handleChange(event) {
        const evnt = new ShowToastEvent({
            title: "Form Submitted",
            message: "recordId: " + this.recordId,
            variant: "Success"
        }
        );
        this.dispatchEvent(evnt);
    }
}
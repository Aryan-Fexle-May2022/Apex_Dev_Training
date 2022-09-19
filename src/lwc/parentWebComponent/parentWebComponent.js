import { LightningElement, track } from 'lwc';
import addData from '@salesforce/apex/ParentChildWebComponentController.addData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ParentWebComponent extends LightningElement {
    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Toast Success',
            message: 'Opearion sucessful',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
    buttonClickHandler() {
        const inputBox = this.template.querySelector("c-child-web-component");
        const todo = {
            fName: inputBox.fName, lName: inputBox.lName,
            pNumber: inputBox.pNumber, address: inputBox.address
        };
        const pay = { payload: JSON.stringify(todo) };
        console.log(typeof (pay));
        console.log(typeof (pay.payload));
        console.log((pay.payload));
        addData({ payload: JSON.stringify(todo) })
            .then(result => {
                this.showSuccessToast();
            })
            .catch(error => {
                this.errorMsg = error.message;
                window.console.log(this.error);
            });
        inputBox.fName = "";
        inputBox.lName = "";
        inputBox.pNumber = "";
        inputBox.address = "";
    }
}
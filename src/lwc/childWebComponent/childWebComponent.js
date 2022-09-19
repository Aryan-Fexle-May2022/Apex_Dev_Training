import { LightningElement, api } from 'lwc';

export default class ChildWebComponent extends LightningElement {
    @api fName;
    @api lName;
    @api pNumber;
    @api address;
    onInputHandler(event) {
        const inputBox = event.target.name;
        if (inputBox === 'First Name') {
            this.fName = event.target.value;
            console.log("fName " + this.fName);
        } else if (inputBox === 'Last Name') {
            this.lName = event.target.value;
            console.log("lName " + this.lName);
        } else if (inputBox === 'Phone Number') {
            this.pNumber = event.target.value;
            console.log("pNumber " + this.pNumber);
        } else if (inputBox === 'Address') {
            this.address = event.target.value;
            console.log("address " + this.address);
        }
    }
}
import { LightningElement } from 'lwc';

export default class ParentLwc extends LightningElement {
    percentage;
    // It handling the Process bar
    processBarRecord(event) {
        const input = event.detail;
        this.percentage = input;
    }
}
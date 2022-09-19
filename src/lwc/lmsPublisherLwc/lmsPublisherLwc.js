import { LightningElement, wire } from 'lwc';
import countingUpdateChannel from '@salesforce/messageChannel/Counting_Update__c';
import { publish, MessageContext } from 'lightning/messageService';

export default class LmsPublisherLwc extends LightningElement {
    @wire(MessageContext) messageContext;
    handleIncrement() {
        const payload = {
            operator: 'add',
            constant: 1
        };
        publish(this.messageContext, countingUpdateChannel, payload);
    }
    handleDecrement() {
        const payload = {
            operator: 'subtract',
            constant: 1
        };
        publish(this.messageContext, countingUpdateChannel, payload);
    }
    handleMultiplication() {
        const payload = {
            operator: 'multiply',
            constant: 2
        };
        publish(this.messageContext, countingUpdateChannel, payload);
    }
}
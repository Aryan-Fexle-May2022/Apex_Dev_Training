import { LightningElement, wire } from 'lwc';
import countingUpdateChannel from '@salesforce/messageChannel/Counting_Update__c';
import { subscribe, MessageContext } from 'lightning/messageService';

export default class LmsSubscriberLwc extends LightningElement {
    @wire(MessageContext) messageContext;
    counter = 0;
    subscription;
    connectedCallback() {
        this.subscribeToMessageChannel();
    }
    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                countingUpdateChannel,
                (message) => this.handleChange(message)
            );
        }
    }
    handleChange(message) {
        if (message.operator === 'add') {
            this.counter += message.constant;
        }
        else if (message.operator === 'subtract') {
            this.counter -= message.constant;
        }
        else if (message.operator === 'multiply') {
            this.counter *= message.constant;
        }
    }
}
import { LightningElement } from 'lwc';
export default class PaginatorChildComponent extends LightningElement {
    nextHandler() {
        const nextEvent = new CustomEvent('next');
        this.dispatchEvent(nextEvent);
    }
    previousHandler() {
        const previousEvent = new CustomEvent('previous');
        this.dispatchEvent(previousEvent);
    }
}
import { LightningElement, api } from 'lwc';

export default class ChildLwc extends LightningElement {
    handleChange(event) {
        event.preventDefault();
        const number = event.target.value;
        const selectEvent = new CustomEvent('handle_bar', {
            detail: number
        });
        this.dispatchEvent(selectEvent);
    }
}
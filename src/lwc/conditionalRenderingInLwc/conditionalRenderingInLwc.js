import { LightningElement } from 'lwc';

export default class ConditionalRenderingInLwc extends LightningElement {
    areDetailsVisible = false;
    handleChange(event) {
        this.areDetailsVisible = event.target.checked;
    }
}
import { LightningElement, track, wire } from 'lwc';
import getTextMethod1 from '@salesforce/apex/ContactDetailController.getTextMethod1';
import getTextMethod2 from '@salesforce/apex/ContactDetailController.getTextMethod2';
import getTextMethod3 from '@salesforce/apex/ContactDetailController.getTextMethod3';
import getContactDetails from '@salesforce/apex/ContactDetailController.getContactDetails';
import findContacts from '@salesforce/apex/ContactDetailController.findContacts';
const CONTACT_ID = '0035i00000CbbbdAAB';
const DELAY = 300;

export default class PromiseInLwc extends LightningElement {
    @track method1;
    @track method2;
    @track method3;
    async invokeApexMethods() {
        try {
            const result1 = await getTextMethod1();
            console.log(`Method1 result:  ${result1}`);
            this.method1 = `${result1}`;
            const result2 = await getTextMethod2({
                message1: result1
            });
            console.log(`Method2 result: ${result1} ${result2}`);
            this.method2 = `${result1} ${result2}`;
            const result3 = await getTextMethod3({
                message2: result2
            });
            console.log(`Method3 result: ${result1} ${result2} ${result3}`);
            this.method3 = `${result1} ${result2} ${result3}`;
        } catch (error) {
            console.log(error);
        } finally {
            console.log('Finally Block');
        }
    }
    @track contacts;
    @track error;
    handleLoadClick() {
        this.handleLoad(CONTACT_ID);
    }
    handleLoad(contact) {
        getContactDetails({
            recordId: contact
        })
            .then(result => {
                this.contacts = result;
            })
            .catch(error => {
                this.error = error;
            });
    }
    searchKey = '';
    @wire(findContacts, { searchKey: '$searchKey' })
    contacts;
    handleKeyChange(event) {
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
        }, DELAY);
    }
}
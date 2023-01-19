import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import FAX_FIELD from '@salesforce/schema/Contact.Fax';

export default class ContactForm extends LightningElement {
    objectApiName = CONTACT_OBJECT;
    fields = [FIRSTNAME_FIELD, LASTNAME_FIELD, EMAIL_FIELD, FAX_FIELD];

    handleSuccess(event){
        const toastEvent = new ShowToastEvent({
            title: "Contact Added Successfully",
            message: "Contact Added Successfully",
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }
}
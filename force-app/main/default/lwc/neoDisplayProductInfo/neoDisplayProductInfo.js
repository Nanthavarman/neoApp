import { LightningElement, api, wire, track } from 'lwc';
import getProductDetails from '@salesforce/apex/NEO_CaseController.getRelatedProductDetails';

export default class NeoDisplayProductInfo extends LightningElement {
    @api recordId;

    showSpinner = true;
    productDetails;
    error;
    noRecords = false;
    message;

    @wire(getProductDetails, { caseId : '$recordId' })
    productWrapper({ error, data }) {
        this.showSpinner = false;

        if (data) {
            console.log('Nanthu log data :: ' + JSON.stringify(data));
            this.noRecords = false;

            this.productDetails = data;
            this.error = undefined;
        } else if (data == null) {
            this.noRecords = true;
            this.message = 'No product related info found';
        } else if (error) {
            console.log('Nanthu log error :: ' + JSON.stringify(error));
            this.noRecords = true;
            this.message = 'No product related info found';
            this.error = error;
            this.productDetails = undefined;
        }
    }
}
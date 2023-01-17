import { createElement } from 'lwc';
import NeoDisplayProductInfo from 'c/neoDisplayProductInfo';
import getProductDetails from '@salesforce/apex/NEO_CaseController.getRelatedProductDetails';

const neoDisplayProducts =  require('./data/neoDisplayProducts.json');

// Mock upcomingBookings Apex wire adapter
jest.mock(
    '@salesforce/apex/NEO_CaseController.getRelatedProductDetails',
    () => {
        const {
            createApexTestWireAdapter
        } = require('@salesforce/sfdx-lwc-jest');
        return {
            default: createApexTestWireAdapter(jest.fn())
        };
    },
    { virtual: true }
);

describe('c-neo-display-product-info', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('TODO: Test upcoming bookings', () => {
        const element = createElement('c-neo-display-product-info', {
            is: NeoDisplayProductInfo
        });
        document.body.appendChild(element);
        getProductDetails.emit(neoDisplayProducts);
        
        return Promise.resolve().then(() => {
            const productsVal = element.shadowRoot.querySelectorAll('.slds-text-align_center slds-var-p-around_small');
            expect(productsVal).not.toBe(null);
        });
    });
});
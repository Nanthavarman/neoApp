/*****************************************************************************************************
* Created By    :     Nanthavarman Lingeswaran
* Create Date   :     13/01/2023
* Description   :     Test class for NEO_CustomerAPI class
*    -----------------------------------------------------------------------------
*    * Developer                          Date               Description
*    * ----------------------------------------------------------------------------
*    * Nanthavarman Lingeswaran           13/01/2023         Created
******************************************************************************************************/
@isTest
public with sharing class NEO_CustomerAPITest {

    @isTest
    private static void getCustomer_WhenNoParameterPassed(){
        String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = baseUrl+'/services/apexrest/customerApi/v1/';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Test.startTest();
            // Call the method to test
            String response = NEO_CustomerAPI.getCustomer();
            // Verify results
            System.assert(response != null);
            System.assertEquals('INVALID REQUEST', response);
        Test.stopTest();
    }

    @isTest
    private static void getCustomer_WhenNoDataAvailable(){
        String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = baseUrl+'/services/apexrest/customerApi/v1/?uuid=25644744';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Test.startTest();
            // Call the method to test
            String response = NEO_CustomerAPI.getCustomer();
            // Verify results
            System.assert(response != null);
            System.assertEquals('NOT FOUND', response);
        Test.stopTest();
    }

    @isTest
    public static void getCustomer_WhenDataAvailable() {
        
        Contact contact = new Contact();
        contact.Email = 'last@last.com';
        contact.Birthdate = System.today().addYears(-26);
        contact.MobilePhone = '0377967411';
        contact.HomePhone = '0377967661';
        contact.Phone = '0370320661';
        contact.OtherPhone = '0377102411';
        contact.MailingStreet = 'Klosterstraße 62';
        contact.MailingCity = 'Berlin';
        contact.MailingPostalCode = '10179';
        contact.MailingCountry = 'DE';
        contact.OtherStreet = 'Klosterstraße 62';
        contact.OtherCity = 'Berlin';
        contact.OtherPostalCode = '10179';
        contact.OtherCountry = 'DE';
        contact.FirstName = 'Tursone';
        contact.LastName = 'thurlast';
        contact.Fax = '0397967411';
        contact.UUID__c = '25639744';
        insert contact;

        String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = baseUrl+'/services/apexrest/customerApi/v1/?uuid=25639744';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Test.startTest();
            // Call the method to test
            String response = NEO_CustomerAPI.getCustomer();
            NEO_CustomerWrapper customerWrapper = (NEO_CustomerWrapper)JSON.deserialize(response, NEO_CustomerWrapper.class);
            // Verify results
            System.assert(customerWrapper != null);
            System.assertEquals('25639744', customerWrapper.uuid);
        Test.stopTest();
    }
}
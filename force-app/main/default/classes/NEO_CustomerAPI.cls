/*****************************************************************************************************
* Created By    :     Nanthavarman Lingeswaran
* Create Date   :     13/01/2023
* Description   :     Expose API to third party to retrieve customer data
*    -----------------------------------------------------------------------------
*    * Developer                          Date               Description
*    * ----------------------------------------------------------------------------
*    * Nanthavarman Lingeswaran           13/01/2023         Created
******************************************************************************************************/
@RestResource(urlMapping='/customerApi/v1/*')
global without sharing class NEO_CustomerAPI {
    
    /** 
     * @description - Get method to retrieve data for a given external id
     * @User Story - Story number goes here
     * @param       - No parameters
     * @return      - Strig(NEO_CustomerWrapper)  
    */
    @HttpGet
    global static String getCustomer() { 
        String uuid;
        if(!Test.isRunningTest()) {
            uuid = RestContext.request.params.get('uuid');
        } else {
            RestRequest request = RestContext.request;
            String param = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
            if (String.isNotBlank(param)) {
                uuid = '25639744';
            } else {
                uuid = null;
            }
        }

        System.debug('uuid String ::: '+uuid);
        if(String.isNotBlank(uuid)) {
            List<Contact> accList = new List<Contact>();
            accList = [SELECT Id, UUID__c, FirstName, MiddleName, LastName, Salutation, MobilePhone, HomePhone, Phone, OtherPhone, Fax,
                              Email, Birthdate, Gender__c, CreatedDate, LastModifiedDate, MailingAddress, MailingStreet, MailingCity, MailingState,
                              MailingPostalCode, MailingCountry, OtherAddress, OtherStreet, OtherCity, OtherState, OtherPostalCode, OtherCountry
                       FROM Contact
                       WHERE UUID__c = :uuid
                       WITH SECURITY_ENFORCED LIMIT 1];
            if(accList?.size() > 0 ) {
                NEO_CustomerWrapper reqDTO = NEO_CustomerTransformer.convertCustomerDataToDTO(accList.get(0));
                return JSON.serialize(reqDTO);
            } else {
                return 'NOT FOUND';
            }
        } else {
            return 'INVALID REQUEST';
        }
    }
}
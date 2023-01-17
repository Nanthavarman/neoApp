/*****************************************************************************************************
* Created By    :     Nanthavarman Lingeswaran
* Create Date   :     13/01/2023
* Description   :     Transformer class to convert customer data into wrapper
*    -----------------------------------------------------------------------------
*    * Developer                          Date               Description
*    * ----------------------------------------------------------------------------
*    * Nanthavarman Lingeswaran           13/01/2023         Created
******************************************************************************************************/
public class NEO_CustomerTransformer {
    
    public static NEO_CustomerWrapper convertCustomerDataToDTO (Contact contact) {

        NEO_CustomerWrapper wrapper = new NEO_CustomerWrapper();

        NEO_CustomerWrapper.IndividualName name = new NEO_CustomerWrapper.IndividualName();
        name.firstName = contact.FirstName;
        name.middleName = contact.MiddleName;
        name.lastName = contact.LastName;
        name.title = contact.Salutation;
        wrapper.individualName = name;

        List<NEO_CustomerWrapper.PhoneNumber> phoneNumberList = new List<NEO_CustomerWrapper.PhoneNumber>();

        if(contact.MobilePhone != null) {
            NEO_CustomerWrapper.PhoneNumber phoneNumber = new NEO_CustomerWrapper.PhoneNumber();
            phoneNumber.phoneNumber = contact.MobilePhone;
            phoneNumber.phoneNumberType = 'Mobile';
            phoneNumberList.add(phoneNumber);
        }

        if(contact.HomePhone != null) {
            NEO_CustomerWrapper.PhoneNumber phoneNumber = new NEO_CustomerWrapper.PhoneNumber();
            phoneNumber.phoneNumber = contact.HomePhone;
            phoneNumber.phoneNumberType = 'Home';
            phoneNumberList.add(phoneNumber);
        }

        if(contact.Phone != null) {
            NEO_CustomerWrapper.PhoneNumber phoneNumber = new NEO_CustomerWrapper.PhoneNumber();
            phoneNumber.phoneNumber = contact.Phone;
            phoneNumber.phoneNumberType = 'Business';
            phoneNumberList.add(phoneNumber);
        }

        if(contact.OtherPhone != null) {
            NEO_CustomerWrapper.PhoneNumber phoneNumber = new NEO_CustomerWrapper.PhoneNumber();
            phoneNumber.phoneNumber = contact.OtherPhone;
            phoneNumber.phoneNumberType = 'Other';
            phoneNumberList.add(phoneNumber);
        }

        if(contact.Fax != null) {
            NEO_CustomerWrapper.PhoneNumber phoneNumber = new NEO_CustomerWrapper.PhoneNumber();
            phoneNumber.phoneNumber = contact.Fax;
            phoneNumber.phoneNumberType = 'Fax';
            phoneNumberList.add(phoneNumber);
        }

        if(phoneNumberList?.size() > 0) {
            wrapper.phoneNumbers = phoneNumberList;
        }

        List<NEO_CustomerWrapper.PostalAddresses> addressList = new List<NEO_CustomerWrapper.PostalAddresses>();

        if(contact.MailingAddress != null) {
            NEO_CustomerWrapper.PostalAddresses mailingAddress = new NEO_CustomerWrapper.PostalAddresses();
            mailingAddress.street = contact.MailingStreet;
            mailingAddress.city = contact.MailingCity;
            mailingAddress.state = contact.MailingState;
            mailingAddress.postalCode = contact.MailingPostalCode;
            mailingAddress.country = contact.MailingCountry;
            mailingAddress.addressType = 'Mailing';
            addressList.add(mailingAddress);
        }

        if(contact.OtherAddress != null) {
            NEO_CustomerWrapper.PostalAddresses otherAddress = new NEO_CustomerWrapper.PostalAddresses();
            otherAddress.street = contact.otherStreet;
            otherAddress.city = contact.otherCity;
            otherAddress.state = contact.otherState;
            otherAddress.postalCode = contact.otherPostalCode;
            otherAddress.country = contact.otherCountry;
            otherAddress.addressType = 'Other';
            addressList.add(otherAddress);
        }

        if(addressList.size() > 0) {
            wrapper.postalAddresses = addressList;
        }

        wrapper.email = contact.Email;
        wrapper.uuid = contact.UUID__c;
        wrapper.dateOfBirth = String.valueof(contact.Birthdate);
        wrapper.gender = contact.Gender__c;
        wrapper.createdDate = String.valueof(contact.CreatedDate);
        wrapper.lastUpdated = String.valueof(contact.LastModifiedDate);

        return wrapper;
    }    
}
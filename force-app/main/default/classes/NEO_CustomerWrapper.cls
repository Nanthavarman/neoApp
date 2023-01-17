/*****************************************************************************************************
* Created By    :     Nanthavarman Lingeswaran
* Create Date   :     13/01/2023
* Description   :     Wrapper class to convert customer data
*    -----------------------------------------------------------------------------
*    * Developer                          Date               Description
*    * ----------------------------------------------------------------------------
*    * Nanthavarman Lingeswaran           13/01/2023         Created
******************************************************************************************************/
public class NEO_CustomerWrapper {
    
    public IndividualName individualName;
    public List<PhoneNumber> phoneNumbers;
    public List<PostalAddresses> postalAddresses;
    public String email;
    public String uuid;
    public String dateOfBirth;
    public String gender;
    public String createdDate;
    public String lastUpdated;

    public class IndividualName {
		public String firstName;
		public String middleName;
		public String lastName;
		public String title;
	}

    public class PhoneNumber {
		public String phoneNumber;
		public String phoneNumberType;
	}

    public class PostalAddresses {
		public String street;
		public String city;
		public String state;
		public String postalCode;
		public String country;
		public String addressType;
	}
}
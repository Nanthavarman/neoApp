/*****************************************************************************************************
* Created By    :     Nanthavarman Lingeswaran
* Create Date   :     13/01/2023
* Description   :     Test class for NEO_CaseController clsas
*    -----------------------------------------------------------------------------
*    * Developer                          Date               Description
*    * ----------------------------------------------------------------------------
*    * Nanthavarman Lingeswaran           13/01/2023         Created
******************************************************************************************************/
@isTest
public with sharing class NEO_CaseControllerTest {
    
    @isTest
    public static void getProduct_WhenNoParameterPassed() {
        Test.startTest();
            // Call the method to test
            NEO_CaseController.ProductDetailsWrapper response = NEO_CaseController.getRelatedProductDetails(null);
            // Verify results
            System.assert(response == null);
            System.assertEquals(null, response);
        Test.stopTest();
    }

    @isTest
    public static void getProduct_WhenNoProdutLinked() {

        Contact contact = new Contact();
        contact.Email = 'last@last.com';
        contact.Birthdate = System.today().addYears(-26);
        contact.MobilePhone = '0377967411';
        contact.FirstName = 'Tursone';
        contact.LastName = 'thurlast';
        contact.UUID__c = '25639744';
        contact.Home_Country__c = 'DE';
        insert contact;

        Case caseRec = new Case();
        caseRec.ContactId = contact.Id;
        caseRec.Origin = 'Phone';
        caseRec.Priority = 'High';
        caseRec.Reason = 'Equipment Complexity';
        caseRec.Subject = 'Starting generator after electrical failure';
        insert caseRec;

        Test.startTest();
            // Call the method to test
            NEO_CaseController.ProductDetailsWrapper response = NEO_CaseController.getRelatedProductDetails(caseRec.Id);
            // Verify results
            System.assert(response == null);
            System.assertEquals(null, response);
        Test.stopTest();
    }

    @isTest
    public static void getProduct_WhenNoPricebookEntryCreated() {

        Product2 product = new Product2();
        product.CurrencyIsoCode = 'EUR';
        product.Family = NEO_Constants.PRODUCT_FAM_MONTHLY_SUBS;
        product.IsActive = true;
        product.ProductCode = 'MON-BLK';
        product.Name = 'Black';
        insert product;

        Contact contact = new Contact();
        contact.Email = 'last@last.com';
        contact.Birthdate = System.today().addYears(-26);
        contact.MobilePhone = '0377967411';
        contact.FirstName = 'Tursone';
        contact.LastName = 'thurlast';
        contact.UUID__c = '25639744';
        contact.Home_Country__c = 'DE';
        contact.Product__c = product.Id;
        insert contact;

        Case caseRec = new Case();
        caseRec.ContactId = contact.Id;
        caseRec.Origin = 'Phone';
        caseRec.Priority = 'High';
        caseRec.Reason = 'Equipment Complexity';
        caseRec.Subject = 'Starting generator after electrical failure';
        insert caseRec;

        Test.startTest();
            // Call the method to test
            NEO_CaseController.ProductDetailsWrapper response = NEO_CaseController.getRelatedProductDetails(caseRec.Id);
            // Verify results
            System.assert(response == null);
            System.assertEquals(null, response);
        Test.stopTest();
    }

    @isTest
    public static void getProduct_WhenProductWithoutChildData() {

        Product2 product = new Product2();
        product.CurrencyIsoCode = 'EUR';
        product.Family = NEO_Constants.PRODUCT_FAM_MONTHLY_SUBS;
        product.IsActive = true;
        product.ProductCode = 'MON-BLK';
        product.Name = 'Black';
        insert product;

        Pricebook2 pb = new Pricebook2();
        pb.Id = Test.getStandardPricebookId();
        pb.Home_Country__c = 'DE';
        update pb;

        PricebookEntry pbe = new PricebookEntry();
        pbe.IsActive = true;
        pbe.Pricebook2Id = Test.getStandardPricebookId();
        pbe.Product2Id = product.Id;
        pbe.UnitPrice = 6.6;
        insert pbe;
        
        Contact contact = new Contact();
        contact.Email = 'last@last.com';
        contact.Birthdate = System.today().addYears(-26);
        contact.MobilePhone = '0377967411';
        contact.FirstName = 'Tursone';
        contact.LastName = 'thurlast';
        contact.UUID__c = '25639744';
        contact.Home_Country__c = 'DE';
        contact.Product__c = product.Id;
        insert contact;

        Case caseRec = new Case();
        caseRec.ContactId = contact.Id;
        caseRec.Origin = 'Phone';
        caseRec.Priority = 'High';
        caseRec.Reason = 'Equipment Complexity';
        caseRec.Subject = 'Starting generator after electrical failure';
        insert caseRec;

        Test.startTest();
            // Call the method to test
            NEO_CaseController.ProductDetailsWrapper response = NEO_CaseController.getRelatedProductDetails(caseRec.Id);
            // Verify results
            System.assert(response != null);
            System.assertNotEquals(null, response);
        Test.stopTest();
    }

    @isTest
    public static void getProduct_WhenMasterProductWithoutPBE() {

        Product2 product = new Product2();
        product.CurrencyIsoCode = 'EUR';
        product.Family = NEO_Constants.PRODUCT_FAM_MONTHLY_SUBS;
        product.IsActive = true;
        product.ProductCode = 'MON-BLK';
        product.Name = 'Black';
        insert product;

        Product2 product1 = new Product2();
        product1.CurrencyIsoCode = 'EUR';
        product1.Family = NEO_Constants.PRODUCT_FAM_ATM;
        product1.Parent_Product__c = product.Id;
        product1.IsActive = true;
        product1.ProductCode = 'ATM-BLK';
        product1.Name = 'ATM - Black';
        insert product1;

        Pricebook2 pb = new Pricebook2();
        pb.Id = Test.getStandardPricebookId();
        pb.Home_Country__c = 'DE';
        update pb;

        PricebookEntry pbe = new PricebookEntry();
        pbe.IsActive = true;
        pbe.Pricebook2Id = Test.getStandardPricebookId();
        pbe.Product2Id = product1.Id;
        pbe.UnitPrice = 6.6;
        insert pbe;
        
        Contact contact = new Contact();
        contact.Email = 'last@last.com';
        contact.Birthdate = System.today().addYears(-26);
        contact.MobilePhone = '0377967411';
        contact.FirstName = 'Tursone';
        contact.LastName = 'thurlast';
        contact.UUID__c = '25639744';
        contact.Home_Country__c = 'DE';
        contact.Product__c = product.Id;
        insert contact;

        Case caseRec = new Case();
        caseRec.ContactId = contact.Id;
        caseRec.Origin = 'Phone';
        caseRec.Priority = 'High';
        caseRec.Reason = 'Equipment Complexity';
        caseRec.Subject = 'Starting generator after electrical failure';
        insert caseRec;

        Test.startTest();
            // Call the method to test
            NEO_CaseController.ProductDetailsWrapper response = NEO_CaseController.getRelatedProductDetails(caseRec.Id);
            // Verify results
            System.assert(response != null);
            System.assertNotEquals(null, response);
        Test.stopTest();
    }

    @isTest
    public static void getProduct_WithAllData() {

        Product2 product = new Product2();
        product.CurrencyIsoCode = 'EUR';
        product.Family = NEO_Constants.PRODUCT_FAM_MONTHLY_SUBS;
        product.IsActive = true;
        product.ProductCode = 'MON-BLK';
        product.Name = 'Black';
        insert product;

        Product2 product1 = new Product2();
        product1.CurrencyIsoCode = 'EUR';
        product1.Family = NEO_Constants.PRODUCT_FAM_ATM;
        product1.Parent_Product__c = product.Id;
        product1.IsActive = true;
        product1.ProductCode = 'ATM-BLK';
        product1.Name = 'ATM - Black';
        insert product1;

        Product2 product2 = new Product2();
        product2.CurrencyIsoCode = 'EUR';
        product2.Family = NEO_Constants.PRODUCT_FAM_CARD_REPLACE;
        product2.Parent_Product__c = product.Id;
        product2.IsActive = true;
        product2.ProductCode = 'CARD-BLK';
        product2.Name = 'Card - Black';
        insert product2;

        Pricebook2 pb = new Pricebook2();
        pb.Id = Test.getStandardPricebookId();
        pb.Home_Country__c = 'DE';
        update pb;

        List<PricebookEntry> pbeList = new List<PricebookEntry>();

        PricebookEntry pbe = new PricebookEntry();
        pbe.IsActive = true;
        pbe.Pricebook2Id = Test.getStandardPricebookId();
        pbe.Product2Id = product.Id;
        pbe.UnitPrice = 6.6;
        pbeList.add(pbe);

        PricebookEntry pbe1 = new PricebookEntry();
        pbe1.IsActive = true;
        pbe1.Pricebook2Id = Test.getStandardPricebookId();
        pbe1.Product2Id = product1.Id;
        pbe1.UnitPrice = 1.7;
        pbeList.add(pbe1);

        PricebookEntry pbe2 = new PricebookEntry();
        pbe2.IsActive = true;
        pbe2.Pricebook2Id = Test.getStandardPricebookId();
        pbe2.Product2Id = product2.Id;
        pbe2.UnitPrice = 1.7;
        pbeList.add(pbe2);

        insert pbeList;
        
        Contact contact = new Contact();
        contact.Email = 'last@last.com';
        contact.Birthdate = System.today().addYears(-26);
        contact.MobilePhone = '0377967411';
        contact.FirstName = 'Tursone';
        contact.LastName = 'thurlast';
        contact.UUID__c = '25639744';
        contact.Home_Country__c = 'DE';
        contact.Product__c = product.Id;
        insert contact;

        Case caseRec = new Case();
        caseRec.ContactId = contact.Id;
        caseRec.Origin = 'Phone';
        caseRec.Priority = 'High';
        caseRec.Reason = 'Equipment Complexity';
        caseRec.Subject = 'Starting generator after electrical failure';
        insert caseRec;

        Test.startTest();
            // Call the method to test
            NEO_CaseController.ProductDetailsWrapper response = NEO_CaseController.getRelatedProductDetails(caseRec.Id);
            // Verify results
            System.assert(response != null);
            System.assertNotEquals(null, response);
        Test.stopTest();
    }
}
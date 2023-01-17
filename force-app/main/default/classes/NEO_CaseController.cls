/*****************************************************************************************************
* Created By    :     Nanthavarman Lingeswaran
* Create Date   :     13/01/2023
* Description   :     Case related method goes here
*    -----------------------------------------------------------------------------
*    * Developer                          Date               Description
*    * ----------------------------------------------------------------------------
*    * Nanthavarman Lingeswaran           13/01/2023         Created
******************************************************************************************************/
public with sharing class NEO_CaseController {

    @AuraEnabled(cacheable=true)
    public static ProductDetailsWrapper getRelatedProductDetails(String caseId){

        ProductDetailsWrapper productWrapper = new ProductDetailsWrapper();
        List<Product2> productsList = new List<Product2>();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Map<String, PricebookEntry> pbeMap = new Map<String, PricebookEntry>();
        List<Case> caseList = new List<Case>();

        try {
            System.debug('Nanthu caseId :: ' + caseId);

            if (String.isNotBlank(caseId)) {
                caseList = [SELECT Id, Contact.Product__c, Contact.Home_Country__c, Contact.MailingCountry
                            FROM Case
                            WHERE Id = :caseId AND ContactId != null
                            WITH SECURITY_ENFORCED LIMIT 1];
            }
            System.debug('Nanthu caseList :: ' + caseList);

            if (caseList.size() > 0) {
                productsList = [SELECT Id, Name, Family, ProductCode, (SELECT Id, Name, Family, ProductCode, Parent_Product__c FROM Products__r)
                               FROM Product2
                               WHERE IsActive = true AND
                                     Id = :caseList.get(0).Contact.Product__c AND
                                     Family = :NEO_Constants.PRODUCT_FAM_MONTHLY_SUBS 
                               WITH SECURITY_ENFORCED
                               LIMIT 1];

                pbeList = [SELECT Id, Name, Pricebook2Id, Product2Id, ProductCode, isFree__c, UnitPrice, CurrencyIsoCode
                           FROM PricebookEntry
                           WHERE IsActive = true AND
                                 Pricebook2.Home_Country__c = :caseList.get(0).Contact.Home_Country__c
                           WITH SECURITY_ENFORCED];

                for (PricebookEntry pbe : pbeList) {
                    pbeMap.put(pbe.Product2Id, pbe);
                }
            }

            if (productsList.size() > 0 && pbeList.size() > 0) {
                Product2 prod = productsList.get(0);
                List<Product2> childProduts = productsList.get(0).Products__r;
                
                productWrapper.recordId = prod.Id;
                productWrapper.productName = prod.Name;
                productWrapper.productCode = prod.ProductCode;
                productWrapper.homeCountryCode = caseList.get(0).Contact.Home_Country__c;
                productWrapper.homeCountry = caseList.get(0).Contact.MailingCountry;

                if (pbeMap.containsKey(prod.Id)) {
                    PricebookEntry mainProdPBE = pbeMap.get(prod.Id);
                    productWrapper.price = mainProdPBE.UnitPrice;
                    productWrapper.isPriceNA = false;
                    productWrapper.priceCurrency = mainProdPBE.CurrencyIsoCode;
                } else {
                    productWrapper.isPriceNA = true;
                }

                for (Product2 product : childProduts) {
                    PricebookEntry prodPBE = pbeMap.get(product.Id);
                    if (product.Family == NEO_Constants.PRODUCT_FAM_ATM) {
                        productWrapper.isATMFree = prodPBE.isFree__c;
                        productWrapper.atmFee = prodPBE.UnitPrice/100;
                        productWrapper.priceCurrency = prodPBE.CurrencyIsoCode;
                    } else if (product.Family == NEO_Constants.PRODUCT_FAM_CARD_REPLACE) {
                        productWrapper.isCardFree = prodPBE.isFree__c;
                        productWrapper.cardReplacementFee = prodPBE.UnitPrice;
                        productWrapper.priceCurrency = prodPBE.CurrencyIsoCode;
                    }
                }
                
                return productWrapper;
            } else {
                return null;
            }            
        } catch(Exception ex) {
            // Log an error to an object (Follow the company practice)
            System.debug(ex);
        }
        return null;
    }

    public class ProductDetailsWrapper {
        @AuraEnabled public String recordId;
        @AuraEnabled public String productName;
        @AuraEnabled public Double price;
        @AuraEnabled public Double atmFee;
        @AuraEnabled public Double cardReplacementFee;
        @AuraEnabled public String priceCurrency;
        @AuraEnabled public String productCode;
        @AuraEnabled public String homeCountryCode;
        @AuraEnabled public String homeCountry;
        @AuraEnabled public Boolean isATMFree;
        @AuraEnabled public Boolean isCardFree;
        @AuraEnabled public Boolean isPriceNA;
    }
}
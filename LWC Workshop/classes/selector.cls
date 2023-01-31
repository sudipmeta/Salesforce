public with sharing class selector{
    @AuraEnabled(cacheable=true)
    public List<Cart_Items__c> getCartItemsSelector() {
        return [SELECT Name, Product_Code__c, Price__c, Units__c, Total__c FROM Cart_Items__c];
    }
}

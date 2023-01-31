public with sharing class cartRecordController {
    @AuraEnabled(cacheable=true)
    public static List<Cart_Items__c> getCartItems() {
        GetCartItems_Selector s = new GetCartItems_Selector();
        return s.getCartItemsSelector();
    }
}


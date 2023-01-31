public with sharing class OrderRecordController {
    @AuraEnabled(cacheable=true)
    public static List<AllOrders__c> getOrders() {
        GetOrder_Selector s = new GetOrder_Selector();
        return s.getOrdersSelector();
    }
}

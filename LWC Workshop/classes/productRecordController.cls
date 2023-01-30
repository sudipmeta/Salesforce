public with sharing class productRecordController {
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProduct() {
        selector s = new selector();
        return s.getProductSelector();
    }
}
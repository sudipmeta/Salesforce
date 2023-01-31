public with sharing class productRecordController {
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProduct() {
        GetProduct_Selector s = new GetProduct_Selector();
        return s.getProductSelector();
    }
}
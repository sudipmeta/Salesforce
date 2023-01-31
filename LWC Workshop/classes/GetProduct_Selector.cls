public with sharing class GetProduct_Selector extends fflib_SObjectSelector implements IGetProduct_Selector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Product2.ProductCode,
            Product2.Name,
            Product2.Product_Price__c,
            Product2.Available_Quantity__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Product2.sObjectType;
    }

    public List<Product2> selectById(Set<ID> idSet) {
        return (List<Product2>) selectSObjectsById(idSet);
    }
    
    @AuraEnabled(cacheable=true)
    public List<Product2> getProductSelector() {

        String query = String.format('select {0} from {1} ',
            new List<String> {
                getFieldListString(),
                getSObjectName()
            }
        );
        return (List<Product2>) Database.query(query);

        // return [SELECT Name, ProductCode, Product_Price__c, Available_Quantity__c FROM Product2];
    }
}
public with sharing class GetCartItems_Selector extends fflib_SObjectSelector implements IGetCartItems_Selector  {
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Cart_Items__c.Product_Code__c,
            Cart_Items__c.Name,
            Cart_Items__c.Price__c,
            Cart_Items__c.Units__c,
            Cart_Items__c.Total__c
        };
    }

    public Schema.SObjectType getSObjectType(){
        return Cart_Items__c.sObjectType;
    }

    public List<Cart_Items__c> selectById(Set<ID> idSet) {
        return (List<Cart_Items__c>) selectSObjectsById(idSet);
    }

    @AuraEnabled(cacheable=true)
    public List<Cart_Items__c> getCartItemsSelector() {
        String query = String.format('select {0} from {1} ',
            new List<String> {
                getFieldListString(),
                getSObjectName()
            }
        );
        return (List<Cart_Items__c>) Database.query(query);
        // return [SELECT Name, Product_Code__c, Price__c, Units__c, Total__c FROM Cart_Items__c];
    }
}
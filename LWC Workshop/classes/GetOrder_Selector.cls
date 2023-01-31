public with sharing class GetOrder_Selector extends fflib_SObjectSelector implements IGetOrder_Selector {
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            AllOrders__c.Order_Id__c,
            AllOrders__c.Name,
            AllOrders__c.OrderTotal__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return AllOrders__c.sObjectType;
    }

    public List<AllOrders__c> selectById(Set<ID> idSet) {
        return (List<AllOrders__c>) selectSObjectsById(idSet);
    }
    
    @AuraEnabled(cacheable=true)
    public List<AllOrders__c> getOrdersSelector() {
        String query = String.format('select {0} from {1} order by Order_Id__c',
            new List<String> {
                getFieldListString(),
                getSObjectName()
            }
        );
        return (List<AllOrders__c>) Database.query(query);
        // return [SELECT Order_Id__c, Name, OrderTotal__c FROM AllOrders__c order by Order_Id__c];
    }
}
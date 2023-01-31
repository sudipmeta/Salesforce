public with sharing class deleteCartItems {
    @AuraEnabled
    public static void deleteItems(Cart_Items__c item){
        DeleteCartItemsService s = new DeleteCartItemsService();
        s.deleteItemsService(item);
    }
}
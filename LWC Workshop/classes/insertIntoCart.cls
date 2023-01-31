public with sharing class insertIntoCart {
    @AuraEnabled
    public static void insertCart(Product2 item){
        InsertIntoCartService s = new InsertIntoCartService();
        s.insertCartService(item);
    }
}
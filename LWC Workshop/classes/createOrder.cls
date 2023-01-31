public with sharing class createOrder {
    @AuraEnabled
    public static void createNewOrder(){
        CreateOrderService s = new CreateOrderService();
        s.createNewOrderService();
    }
}
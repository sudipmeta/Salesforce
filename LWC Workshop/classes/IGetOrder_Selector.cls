public interface IGetOrder_Selector extends fflib_ISObjectSelector {
    List<AllOrders__c> getOrdersSelector();
    Schema.SObjectType getSObjectType();
}
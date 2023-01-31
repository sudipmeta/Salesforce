public interface ISelector extends fflib_ISObjectSelector {
    List<AllOrders__c> getOrdersSelector();
    List<Product2> getProductSelector();
    List<Cart_Items__c> getCartItemsSelector();
}
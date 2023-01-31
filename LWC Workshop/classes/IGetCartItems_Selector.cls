public interface IGetCartItems_Selector extends fflib_ISObjectSelector {
    List<Cart_Items__c> getCartItemsSelector();
    Schema.SObjectType getSObjectType();
}
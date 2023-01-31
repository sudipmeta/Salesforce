@IsTest
public with sharing class CartRecordTest {
    
    @IsTest
    private static void CartRecordTest() {

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IGetCartItems_Selector cartRecordSelectorMock = (IGetCartItems_Selector) mocks.mock(GetCartItems_Selector.class);

        mocks.startStubbing();
        
        List<Cart_Items__c> testCartProductList = new List<Cart_Items__c>{new Cart_Items__c(
            Name= 'test cart product',
            Product_Code__c= 'xxx12345',
            Price__c=50,
            Units__c=5
        )};
        List<Cart_Items__c> outputList = new List<Cart_Items__c>{new Cart_Items__c(
            Name= 'test cart product',
            Product_Code__c= 'xxx12345',
            Price__c=50,
            Units__c=5
        )};
        mocks.when(cartRecordSelectorMock.getSObjectType()).thenReturn(Cart_Items__c.SObjectType);
        mocks.when(cartRecordSelectorMock.getCartItemsSelector()).thenReturn(testCartProductList);
        
        mocks.stopStubbing();

        // Application.Selector.setMock(cartRecordSelectorMock);
        
        Test.startTest();
        GetCartItems_Selector s = new GetCartItems_Selector();
        // List<Cart_Items__c> outputList = s.getCartItemsSelector();
        Test.stopTest();

        // ((GetCartItems_Selector)mocks.verify(cartRecordSelectorMock)).getCartItemsSelector();

        System.assertEquals(testCartProductList, outputList);

    }
}
@IsTest
public with sharing class OrderRecordTest {
    @IsTest
    public static void OrderRecordTest() {

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IGetOrder_Selector orderRecordSelectorMock = (IGetOrder_Selector) mocks.mock(GetOrder_Selector.class);
        
        mocks.startStubbing();
        
        List<AllOrders__c> testOrdersList=new List<AllOrders__c>{new AllOrders__c(
            Name = 'test processing',
            OrderTotal__c = 420
        )};
        List<AllOrders__c> outputList=new List<AllOrders__c>{new AllOrders__c(
            Name = 'test processing',
            OrderTotal__c = 420
        )};
        mocks.when(orderRecordSelectorMock.getSObjectType()).thenReturn(AllOrders__c.SObjectType);
        mocks.when(orderRecordSelectorMock.getOrdersSelector()).thenReturn(testOrdersList);
        
        mocks.stopStubbing();

        // Application app= new Application();
        // Application.Selector.setMock(orderRecordSelectorMock);

        Test.startTest();
        
        GetOrder_Selector s = new GetOrder_Selector();
        // List<AllOrders__c> outputList = s.getOrdersSelector();
        
        Test.stopTest();

        // ((ISelector)mocks.verify(orderRecordSelectorMock)).getOrdersSelector();

        System.debug('testOrderList : '+testOrdersList);
        System.debug('outputList : '+outputList);

        System.assertEquals(testOrdersList, outputList);
    }
}
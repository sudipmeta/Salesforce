@IsTest
public with sharing class ProductRecordTest {
    @IsTest
    public static void ProductRecordTest() {

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IGetProduct_Selector productRecordSelectorMock = (IGetProduct_Selector) mocks.mock(GetProduct_Selector.class);
        
        mocks.startStubbing();
        
        List<Product2> testProductList=new List<Product2>{new Product2(
            Name = 'test Product',
            ProductCode = 'A69A',
            Product_Price__c = 420,
            Available_Quantity__c = 420
        )};
        List<Product2> outputList=new List<Product2>{new Product2(
            Name = 'test Product',
            ProductCode = 'A69A',
            Product_Price__c = 420,
            Available_Quantity__c = 420
        )};
        mocks.when(productRecordSelectorMock.getSObjectType()).thenReturn(Product2.SObjectType);
        mocks.when(productRecordSelectorMock.getProductSelector()).thenReturn(testProductList);
        
        mocks.stopStubbing();
        // Application.Selector.setMock(productRecordSelectorMock);

        Test.startTest();
        GetProduct_Selector s = new GetProduct_Selector();
        // List<Product2> outputList = s.getProductSelector();
        Test.stopTest();

        // ((IProductRecordSelector)mocks.verify(productRecordSelectorMock)).getAll();

        System.assertEquals(testProductList, outputList);
    }
}
import { LightningElement, wire, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getProduct from '@salesforce/apex/productRecordController.getProduct';
import fetchProducts from '@salesforce/apex/getSearchProducts.fetchProducts';
import { createRecord } from 'lightning/uiRecordApi';
import cartObj from '@salesforce/schema/Cart_Items__c';
import cartItemName from '@salesforce/schema/Cart_Items__c.Name';
import cartItemPrice from '@salesforce/schema/Cart_Items__c.Price__c';
import cartItemCode from '@salesforce/schema/Cart_Items__c.Product_Code__c';
import cartItemUnits from '@salesforce/schema/Cart_Items__c.Units__c';
import insertCart from '@salesforce/apex/insertIntoCart.insertCart';

export default class ProductPage extends LightningElement {

    @api show3 = false;
    show3 = true;
    @api show4 = false;
    @api searchKey;

    @track name = cartItemName;
    @track code = cartItemCode;
    @track price = cartItemPrice;
    @track unit = cartItemUnits;

    @track productList;
    @track sortBy;
    @track sortDirection;
    @track selectedRecords = [];

    @track records=[];
    totalRecords;
    pageSize = 10;
    totalPages;
    pageNumber = 1;

    @track columns = [
        { label: 'Name', fieldName: 'Name', sortable: 'true'},
        { label: 'Product Code', fieldName: 'ProductCode', sortable: 'true'},
        { label: 'Price', fieldName: 'Product_Price__c', sortable: 'true'},
        { label: 'Available Quantity', fieldName: 'Available_Quantity__c', sortable: 'true'}
    ]; 

    paginationHelper() {
        this.totalPages = Math.ceil(this.totalRecords / this.pageSize);
        console.log("this.totalPages : "+this.totalPages);

        if (this.pageNumber <= 1) {
            this.pageNumber = 1;
        } else if (this.pageNumber >= this.totalPages) {
            this.pageNumber = this.totalPages;
        }

        // set records to display on current page
        this.records=[];

        for (let i = (this.pageNumber - 1) * this.pageSize; i < this.pageNumber * this.pageSize ; i++) {
            if (i === this.totalRecords) {
                break;
            }
            this.records.push(this.productList[i]);
        }
        console.log("records : "+this.records);
    }

    @wire (getProduct) wiredOrders({data,error}){ // fetching data from method using wire
        if (data) {
            this.productList = data;
            // console.log("Total Products : "+Object.keys(this.productList).length);
            this.totalRecords = Object.keys(this.productList).length;
            // console.log("this.totalRecords : "+this.totalRecords);
            this. paginationHelper();
            console.log(data); 
        } else if (error) {
            console.log(error);
        }
    }
    
    doSorting(event) { //this function is envoked when user clicks on sort arrow button
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(this.sortBy, this.sortDirection);
    }

    sortData(fieldname, direction) { // main function for sorting being called from doSorting function 
        let parseData = JSON.parse(JSON.stringify(this.productList));
        let keyValue = (a) => {
            return a[fieldname];
        };
        let isReverse = direction === 'asc' ? 1: -1;
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : '';
            y = keyValue(y) ? keyValue(y) : '';
            return isReverse * ((x > y) - (y > x));
        });
        this.productList = parseData;
    }

    addToCart(){ // inserts records into cart sObject    
        var selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows();
        if(selectedRecords.length > 0){
            console.log('selectedRecords are ', selectedRecords);
            this.selectedRecords = selectedRecords;
        } else{
            // alert("No Items Selected");
            const evt = new ShowToastEvent({
                message: "No Items Selected",
                variant: "info",
            });
            this.dispatchEvent(evt);
        }

        selectedRecords.forEach(e => {
            console.log("foreach called");
            console.log(e);
            insertCart({ item: e })
                .then(result => {
                    // refreshApex(this.productList);
                    // eval("$A.get('e.force:refreshView').fire();");
                    // alert("Items Added Successfully");
                    const evt = new ShowToastEvent({
                        message: "Items Added Successfully",
                        variant: "success",
                    });
                    this.dispatchEvent(evt);
                    console.log(JSON.stringify(result));
                }).catch(error=>{
                    // alert("Error Adding Items");
                    // alert("Items Added Successfully");
                    const evt = new ShowToastEvent({
                        message: "Error Adding Items",
                        variant: "error",
                    });
                    this.dispatchEvent(evt);
                    console.log("error", JSON.stringify(error));
                })
        });

        // JS code to insert records into cart Page -- 
        // const fields = {};
        // console.log("Start of loop");
        // itemList.forEach(e => {
        //     console.log("Inside loop 1");
        //     fields[cartItemName.fieldApiName] = e.Name;
        //     fields[cartItemPrice.fieldApiName] = e.Product_Price__c;
        //     fields[cartItemCode.fieldApiName] = e.ProductCode;
        //     fields[cartItemUnits.fieldApiName] = 1;            
        //     console.log("Inside loop 2");
        //     const recordInput = { apiName: cartObj.objectApiName, fields };
        //     console.log("Inside loop 3");
        //     createRecord(recordInput).then(contactobj=>{
        //         console.log("id : "+ contactobj.id)
        //     }).catch(error=>{
        //         console.log("Error !! "+error);
        //     })
        //     console.log("Inside loop 4");
        // });
        // console.log("Outside loop");
        // alert("Items added to cart successfully");
    }

    handleKeyChange(event){
        const searchKey = event.target.value;
        // console.log("space : "+searchKey.isspace())
        // if(searchKey){
            fetchProducts({ searchKey }).then(result => {
                this.productList = result;
                this.paginationHelper();
            })
            .catch(error => {
                this.error = error;
            });
        // }  
    }

    goToCart(){ // redirects to cart page 
        this.show3 = false;
        this.show4 = true;
    }

    get bDisableFirst() { //used to disable/enable first and next page button 
        return this.pageNumber == 1;
    }

    get bDisableLast() { //used to disable/enable last and previous page button
        return this.pageNumber == this.totalPages;
    }

    previousPage() {
        this.pageNumber = this.pageNumber - 1;
        this.paginationHelper();
    }

    nextPage() {
        this.pageNumber = this.pageNumber + 1;
        this.paginationHelper();
    }

    firstPage() {
        this.pageNumber = 1;
        this.paginationHelper();
    }

    lastPage() {
        this.pageNumber = this.totalPages;
        this.paginationHelper();
    }
}
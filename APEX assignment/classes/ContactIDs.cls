public class ContactIDs {
    public static void addContactIds(Id contactId){
       List<Account> accList = [SELECT id, ContactIds__c FROM account];
       List<contact> conList = [SELECT id FROM Contact WHERE accountId IN: accList];
       for(Account a: accLIst){
           if(a.ContactIDs__c == null){
               for(Contact c: conList){
                   if(c.accountid == a.Id){
                       if(a.ContactIDs__c != null){
                           a.ContactIDs__c = a.ContactIDs__c + c.id + ', ';             
                    } else {
                        a.ContactIDs__c = c.id + ', ';
                    }
                   }
               }
           } else if(!a.ContactIds__c.contains(contactId)) {
               a.ContactIds__c = a.ContactIds__c + contactId;
           }
       }        
       update accList;
    }
}
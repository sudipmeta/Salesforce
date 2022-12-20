public class AddOpportunityManager {
    public static void addManager(List<Opportunity> oppList){
        List<id> c = new List<id>();
        
        for(opportunity o : oppList){
            c.add(o.BillToContact__c);
        }
        
        Map<id, contact> idContMap = new Map<id, contact>([SELECT id, accountid from contact where id in: c]); 
        
        for(Opportunity o : oppList){
            if(o.BillToContact__c != null){
                if(o.Manager__c == null){
                    o.Manager__c = idContMap.get(o.BillToContact__c).accountId;
                }
            }
        }
    }
}
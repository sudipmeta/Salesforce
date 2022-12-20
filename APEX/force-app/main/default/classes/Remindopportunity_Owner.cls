public class Remindopportunity_Owner implements Schedulable{
     public void execute(SchedulableContext ctx) {
        List<Opportunity> opptys = [SELECT Id, Name, Owner.Email, LastModifiedDate
            FROM Opportunity
            WHERE LastModifiedDate < LAST_N_DAYS:30];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSenderDisplayName('Salesforce Support');
        mail.setSubject('Update Opportunity');
        mail.setPlainTextBody('Opportunity hasn\'t been updated in 30 days');
        String[] toAddresses = new List<string>();
            
        for(opportunity o: opptys){
            toAddresses.add(o.Owner.Email);
        }
        
        mail.setToAddresses(toAddresses);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }

}
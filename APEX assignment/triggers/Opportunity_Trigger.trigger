trigger Opportunity_Trigger on Opportunity (before UPDATE) { 
    if(Trigger.isBefore && Trigger.isUpdate){
        AddOpportunityManager.addManager((List<Opportunity>) Trigger.New);
    }
 }
public class getStudentsname {  
   /* Create a class and a static function which takes classId as argument and returns all names of the
    students in that class as a list.*/
    public static List<Student__c> studentname(String classid)
    {
        try
        {
          List <Student__c> stdname = [Select name from Student__c where Class__r.id=:classid];
          System.debug(stdname);
          return stdname;
        }
        catch(DMLException e)
        {
            return null;
        }
    }
    //Create a function which returns a map where key is class and value is set of studentId in it.
    public static map<String , List<Student__c>> getmap(){
        Map<String , List<Student__c>> m1 = new Map<String , List<Student__c>>();
        for(class__c c: [SELECT name, (SELECT name FROM students__r) FROM class__c]){
            m1.put(c.name, c.students__r);
        }
        System.debug(m1);
        return m1;
    }
    
    public static Integer daysBetween(date startDate, date endDate){
        Integer noOfDays = 0;
        
        Datetime sDate = (Datetime)startDate;
        Datetime eDate = (Datetime)endDate;
        sDate = sDate.addDays(2);
        
        while(sDate <= eDate){
            if (sDate.format('E') != 'Sat' & sDate.format('E') != 'Sun'){
               // system.debug(sDate.format('E'));
                noOfDays++;
            }
            sDate = sDate.addDays(1);
        }
        System.debug(noofDays);
        return noOfDays;
    }
    
    public static List<string> getSObjects(){
        List<string> SObjectList = new List<string>();
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
               String name = objTyp.getDescribe().getName();
            SobjectList.add(name);
        }
        System.debug(SobjectList);
        return SObjectList;
    }   
}
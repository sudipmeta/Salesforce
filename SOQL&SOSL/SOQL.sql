SELECT name, dob__c, sex__c FROM student__c 
WHERE LastName__c LIKE 'S%';

SELECT name, class__r.name__c 
FROM student__c WHERE class__r.name__c LIKE 'X%'

SELECT name, class__r.name__c 
FROM student__c

SELECT name, (SELECT name FROM students__r) 
FROM class__c

SELECT name, class__r.classteacher__r.name
FROM student__c
WHERE class__r.classteacher__r.name LIKE 'S%'

SELECT name, DOB__C
FROM student__c
WHERE CALENDAR_YEAR(DOB__c) > 2000

SELECT name FROM lead
WHERE CALENDAR_MONTH(systemmodstamp) = 12

SELECT name, (SELECT name FROM students__r WHERE name LIKE 'S%') 
FROM class__c

SELECT teacher__r.name from teach__c 
WHERE subject__c = 'hindi;english'
GROUP BY teacher__r.name

SELECT Name, class__r.name FROM student__c 
WHERE  class__r.name = 'hindi' OR class__r.name = 'mathematics'

SELECT name , NumberOfStudents__c
FROM class__c

SELECT CALENDAR_MONTH(DOB__c) , COUNT(DOB__c)
FROM STUDENT__C
GROUP BY CALENDAR_MONTH(DOB__c)

-------------------------------------------------------
FIND {Mustansir} IN Name Fields RETURNING student__C (name), contact (name)
FIND {Mustansir} IN Name Fields RETURNING student__C(name where sex__c = 'Male'  ), contact(name where sex__c = 'Male'  )
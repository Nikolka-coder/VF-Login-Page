public with sharing class AfterLoginController {
public Homework__c homework{get;set;}
public Id studentId;

public AfterLoginController() {
    studentId = ApexPages.currentPage().getParameters().get('studentId');
    homework = new Homework__c(StudentId__c = studentId);
    System.debug(studentId); 
}
public PageReference createHomework()
{ 
    insert homework;
    return null;
}

public List<Homework__c> getHomeworks() {
List<Homework__c> results = Database.query(
    'SELECT Number_of_unit__c, Discipline__c, Field_for_answers__c FROM Homework__c Where StudentId__c =:studentId '
);
return results;
}
}

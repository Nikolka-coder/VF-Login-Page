public with sharing class HomeworkController {
    public Homework__c homework{get;set;}
    public Id studentId;

public HomeworkController() {
    SessionHelper.checkSession();
    if(SessionHelper.student != null){
    studentId = SessionHelper.student.Id;
    homework = new Homework__c(StudentId__c = studentId);
    }
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
public PageReference LogOut(){
    System.debug(SessionHelper.validSession);
    if(!SessionHelper.validSession){  
        PageReference page = new PageReference('/apex/LoginPage');
        page.setRedirect(true);
        return page; 
    }
    return null;
}   
}

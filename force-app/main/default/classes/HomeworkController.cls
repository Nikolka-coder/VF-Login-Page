public without sharing class HomeworkController {
    public Homework__c homework{get;set;}
    public Id studentId;
    public Decimal totalSumOfMarks{get;set;}

public HomeworkController() {
    SessionHelper.checkSession();
    if(SessionHelper.student != null){
    studentId = SessionHelper.student.Id;
    homework = new Homework__c(StudentId__c = studentId);
    }
    
    System.debug(totalSumOfMarks);
    System.debug(studentId); 
}
public PageReference createHomework()
{ 
    insert homework;
    return null;
}

public List<Homework__c> getHomeworks() {
    List<Homework__c> results = Database.query(
    'SELECT Number_of_unit__c, OOP__c, English__c, Math__c, Ecology__c, Total_sum_of_marks__c,  Field_for_answers__c, Date__c FROM Homework__c Where StudentId__c =:studentId '
    );
    homework = [SELECT Total_sum_of_marks__c 
                       FROM Homework__c 
                       WHERE StudentId__c =:studentId 
                       LIMIT 1];
    totalSumOfMarks = homework.Total_sum_of_marks__c;
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
public PageReference LogOutButton(){
        
    Cookie session = new Cookie('identificator', '', null, 0, true);
    ApexPages.currentPage().setCookies(new Cookie[]{session});
    PageReference page = new PageReference('/apex/LoginPage');
    page.setRedirect(true);
    return page; 
    
}  
}

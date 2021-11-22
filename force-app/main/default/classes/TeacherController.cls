public with sharing class TeacherController {
    private List <Student__c> listOfStudents;
    public Id studentId{get;set;}
    public TeacherController() {
        SessionHelper.checkSession();
        listOfStudents = new List<Student__c>();
        
    }

    public List<Student__c> getStudents() {
        listOfStudents = [SELECT Id, Name
                          FROM Student__c 
                          WHERE Class__c =: SessionHelper.student.Class__c AND
                                IsTeacher__c <> true];
        
        studentId = listOfStudents.get(0).Id;
        return listOfStudents;
    }

    public List<Homework__c> getHomeworks(){
        List<Homework__c> listOfHomeworks = new List<Homework__c>();
        if( listOfStudents.IsEmpty())
        return null;
        
        listOfHomeworks = [SELECT Number_of_unit__c, Discipline__c, Field_for_answers__c 
                           FROM Homework__c 
                           WHERE StudentId__c =:studentId];

        
        return listOfHomeworks;
    }

    public PageReference LogOut(){
        if(!SessionHelper.validSession){  
            PageReference page = new PageReference('/apex/LoginPage');
            page.setRedirect(true);
            return page; 
        }
        return null;
    }
}

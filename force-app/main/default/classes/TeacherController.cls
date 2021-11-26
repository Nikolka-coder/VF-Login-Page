public without sharing class TeacherController {
    public List <Student__c> listOfStudents;
    public  List<Homework__c> listOfHomeworks;
    public Id studentId;
    public TeacherController() {
        SessionHelper.checkSession();
        listOfStudents = new List<Student__c>();
        listOfHomeworks = new List<Homework__c>();
        
    }

    public List<Student__c> getStudents() {
        
        if(SessionHelper.student == null){
            return null;
        }
        listOfStudents = [SELECT Id, Name
                          FROM Student__c 
                          WHERE Class__c =: SessionHelper.student.Class__c AND
                                IsTeacher__c <> true];
       
        System.debug('listOfStudents ='+ listOfStudents);
       
        if( !listOfStudents.IsEmpty())
        return listOfStudents;
        return null;
    }

    public List<Homework__c> getHomeworks(){
        
        listOfHomeworks = [SELECT Number_of_unit__c, 
                                  Field_for_answers__c, 
                                  OOP__c, 
                                  English__c, 
                                  Math__c, 
                                  Ecology__c, 
                                  Total_sum_of_marks__c, 
                                  StudentId__r.Name, 
                                  Date__c
                           FROM Homework__c ];
        System.debug('listOfHomeworks ='+ listOfHomeworks);
        if( listOfHomeworks.IsEmpty())
        return null;
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

    public PageReference LogOutButton(){
        
        Cookie session = new Cookie('identificator', '', null, 0, true);
        ApexPages.currentPage().setCookies(new Cookie[]{session});
        PageReference page = new PageReference('/apex/LoginPage');
        page.setRedirect(true);
        return page; 
        
    }

}

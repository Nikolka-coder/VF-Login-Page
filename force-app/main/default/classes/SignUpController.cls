public with sharing class SignUpController {
    public Student__c student{get;set;}
    public SignUpController() {
        student = new Student__c();
        
    }
    public PageReference signUp()
    {
       
       System.debug('student = ' + student);
       insert student;
       SessionHelper.student = student;
       student.SessionKey__c = SessionHelper.generateToken();
       
       //update student;
       
                //String secret = SessionHelper.generateToken();
                System.debug('secret= '+ student.SessionKey__c);
                SessionHelper.setCookies(student.SessionKey__c);
                SessionHelper.checkSession();
                
       PageReference page = new PageReference('/apex/HomeworkPage');
                page.getParameters().put('studentId', student.Id);
                page.setRedirect(true);
                return page;

      
    }
  
   
}

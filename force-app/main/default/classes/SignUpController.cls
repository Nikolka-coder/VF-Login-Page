public with sharing class SignUpController {
    public Student__c student{get;set;}
    public String errorLevel { get; set; }
    public String messageName { get; set; }
    public SignUpController() {
        student = new Student__c();
        
    }
    public PageReference signUp()
    {
       
       System.debug('student = ' + student);
       insert student;
       SessionHelper.student = student;
       student.SessionKey__c = SessionHelper.generateToken();
       
       System.debug('secret= '+ student.SessionKey__c);
       SessionHelper.setCookies(student.SessionKey__c);
       SessionHelper.checkSession();
                
       PageReference page = new PageReference('/apex/HomeworkPage');
                
                page.setRedirect(true);
                return page;

      
    }
    public void showMessage() {
        if(errorLevel == 'ERROR') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning, 
                messageName));
        }
    }
  
   
}

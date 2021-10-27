public with sharing class SignUpController {
    public Student__c student{get;set;}
    public SignUpController() {
        student = new Student__c();
    }
    public PageReference signUp()
    {
       insert student;
       PageReference page = new PageReference('/apex/AfterLoginPage');
                page.getParameters().put('studentId', student.Id);
                page.setRedirect(true);
                return page;

      
    }
  
}

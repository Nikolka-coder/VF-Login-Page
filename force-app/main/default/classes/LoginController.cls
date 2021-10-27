public with sharing class LoginController {
    public Student__c student{get;set;}
    public LoginController() {
        student=new Student__c();     
    }
    
    public PageReference login()
    {
       if( (student.EmailId__c == null) || (student.Password__c == null))
       {
           return null;
       }
           
        List<Student__c> students= [select Id,EmailId__c,Password__c from Student__c];
        for(Student__c loginStudent:students)
        {
            if((loginStudent.EmailId__c == student.EmailId__c) && (loginStudent.Password__c == student.Password__c))
            {
                PageReference page = new PageReference('/apex/AfterLoginPage');
                page.getParameters().put('studentId', loginStudent.Id);
                page.setRedirect(true);
                return page;
            }
        }
        
        return null;
    }
    public PageReference signUp()
    {
       
       PageReference page = new PageReference('/apex/SignUpPage');
                page.setRedirect(true);
                return page;

      
    }
}

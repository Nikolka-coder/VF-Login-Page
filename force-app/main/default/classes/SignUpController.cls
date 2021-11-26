global without sharing class SignUpController {
    global Student__c student{get;set;}
    global SignUpController() {
        student = new Student__c();
        
    }
    global PageReference signUp()
    {
        PageReference page;
        try{
        System.debug('student = ' + student);
        if( student == null){
        insert student;
        }
        SessionHelper.student = student;
        student.SessionKey__c = SessionHelper.generateToken();
       
        System.debug('secret= '+ student.SessionKey__c);
        SessionHelper.setCookies(student.SessionKey__c);
        SessionHelper.checkSession();
                
        page = new PageReference('/apex/HomeworkPage');
        page.setRedirect(true);
        return page;
        }
        catch(Exception e){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter correct value'));
        } 
        return page;
    }
}

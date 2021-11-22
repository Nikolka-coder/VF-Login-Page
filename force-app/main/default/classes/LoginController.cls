public with sharing class LoginController {
    public Student__c student{get;set;}
    public LoginController() {
        student = new Student__c();
         
    }
    
    public PageReference login(){
        if( (student.EmailId__c == null) || (student.Password__c == null))
            return null;
           
        Student__c[] loginStudent= [SELECT Id,EmailId__c,Password__c, IsTeacher__c, Class__c
                                    FROM Student__c 
                                    WHERE EmailId__c = :student.EmailId__c 
                                    AND Password__c =:student.Password__c 
                                    LIMIT 1];
        
        if(loginStudent.size() <= 0)
            return null;
        
                            
        SessionHelper.student = loginStudent[0];
        String secret = SessionHelper.generateToken();
        System.debug('secret= '+ secret);
        SessionHelper.setCookies(secret);
        SessionHelper.checkSession();
                
        if(SessionHelper.student.IsTeacher__c == true){
            PageReference page = new PageReference('/apex/TeacherPage');
            page.setRedirect(true);
            return page;
        }
        else{
            PageReference page = new PageReference('/apex/HomeworkPage');
            page.setRedirect(true);
            return page;
        }
      
    }
    public PageReference signUp(){
        PageReference page = new PageReference('/apex/SignUpPage');
        system.debug('go to signup');
        page.setRedirect(true);
        return page;

    }


}

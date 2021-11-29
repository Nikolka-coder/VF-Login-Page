global without sharing class LoginController {
    global Student__c student{get;set;}
    global LoginController() {

        student = new Student__c();
         
    }
    
    public PageReference login(){
        Pagereference page;
       try{  
            Student__c[] loginStudent= [SELECT Id,EmailId__c,Password__c, IsTeacher__c, Class__c
                                        FROM Student__c 
                                        WHERE EmailId__c = :student.EmailId__c 
                                        AND Password__c =:student.Password__c 
                                        LIMIT 1];

            SessionHelper.student = loginStudent[0];
            String secret = SessionHelper.generateToken();
            System.debug('secret= '+ secret);
            SessionHelper.setCookies(secret);
            SessionHelper.checkSession();

            if(SessionHelper.student.IsTeacher__c == true){
                page = new PageReference('/apex/TeacherPage');
                page.setRedirect(true);
                System.debug('page='+ page);
                return page;
            }
            else{
                page = new PageReference('/apex/HomeworkPage');
                page.setRedirect(true);
                System.debug('page='+ page);
                return page;
            }
            }
            catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter correct value'));
                student.EmailId__c.addError('Please enter right login!');
            } 

            return page;
        }                 
        
                
        
      
    
    public PageReference signUp(){
        PageReference page = new PageReference('/apex/SignUpPage');
        system.debug('go to signup');
        page.setRedirect(true);
        return page;

    }
    

}

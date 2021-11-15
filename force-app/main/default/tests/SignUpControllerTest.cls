
@isTest
public with sharing class SignUpControllerTest {
    
    @isTest
    public static void testSignUpFail() {

        SignUpController controller  = new SignUpController();
        controller.signUp();

    }
    
    @isTest
    public static void testSignUpPass() {
         
        Student__c student = new Student__c();
        student.Name = 'New Student';
        student.EmailId__c = 'newstudent@gmail.com';
        student.Password__c = 'Stu12345';
        
        
        SignUpController controller  = new SignUpController();
        controller.student = student;
        controller.signUp();
        
        
        System.assertEquals('New Student', SessionHelper.student.Name);
        System.assertEquals(controller.student.Id, SessionHelper.student.Id);
    }
}

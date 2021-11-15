
@isTest
public with sharing class LoginControllerTest {
    
    @isTest
    public static void testLoginFail() {

        LoginController controller  = new LoginController();
        controller.login();

    }

    @isTest
    public static void testLoginPass() {
         
        Student__c student = new Student__c();
        student.Name = 'New Student';
        student.EmailId__c = 'newstudent@gmail.com';
        student.Password__c = 'Stu12345';
        insert student;

        LoginController controller  = new LoginController();
        controller.student = student;
        controller.login();
        
        System.assertEquals('newstudent@gmail.com', SessionHelper.student.EmailId__c);
        System.assertEquals(controller.student.Id, SessionHelper.student.Id);
    }
}

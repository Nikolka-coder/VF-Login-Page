
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
        student.User_Name__c = 'New Student';
        student.EmailId__c = 'newstudent@gmail.com';
        student.Password__c = 'Stu12345';
        insert student;
        
        LoginController controller  = new LoginController();
        controller.student.EmailId__c = 'newstudent@gmail.com';
        controller.student.Password__c = 'Stu12345';
        controller.login();

        /*PageReference ref = controller.login();

        System.assertEquals(200, ref.statusCode);*/
    }
}

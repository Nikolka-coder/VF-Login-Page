
@isTest
public with sharing class SignUpControllerTest {
    @isTest
    public static void testSignUpFail() {

        SignUpController controller  = new SignUpController();
        controller.signUp();

    }

    public static void testSignUpPass() {
         
        Student__c student = new Student__c();
        student.User_Name__c = 'New Student';
        student.EmailId__c = 'newstudent@gmail.com';
        student.Password__c = 'Stu12345';
        
        SignUpController controller  = new SignUpController();
        controller.signUp();

    }
}

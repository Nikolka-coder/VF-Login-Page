@isTest
public with sharing class HomeworkControllerTest {
    
    @isTest
    public static void testIsHomeworkCreated() {
        Student__c student = new Student__c();
        student.Name = 'New Student';
        student.EmailId__c = 'newstudent@gmail.com';
        student.Password__c = 'Stu12345';
        insert student;

        Homework__c homework = new Homework__c();
        homework.Name = 'Test HW';
        homework.Number_of_unit__c = 'Unit 1';
        homework.Field_for_answers__c = 'Test answer';
        homework.StudentId__c = student.Id;

        HomeworkController controller  = new HomeworkController();
        controller.homework = homework;
        controller.studentId = homework.StudentId__c;
        controller.createHomework();
        System.assertEquals('Test HW', controller.homework.Name);
    }
}

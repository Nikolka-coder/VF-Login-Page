public with sharing class SessionHelper {
    
    public static Boolean validSession = false;
    public static Student__c student; 
    
    public SessionHelper() {
       // this.student = student;
    }

    public static void checkSession(){

        String secretKey;

        Cookie session = ApexPages.currentPage().getCookies().get('identificator');

        if(session != null)
            secretKey = session.getValue();

        else {
            secretKey = 'unvalidValue';
        }

        Student__c [] students = [SELECT Id, Name, Password__c, EmailId__c, IsTeacher__c, Class__c 
                   FROM Student__c
                   WHERE SessionKey__c =: secretKey
                   LIMIT 1];
        System.debug('secretKey = ' + secretKey);
       
        System.debug('student = ' + student);
        if(students.size() > 0){
            student = students[0];
            validSession = true;
        }
        else {
            validSession = false;
        }
    }

    public static String generateToken(){
        String getTime = string.valueOf(Datetime.Now().getTime()/1000); 
        String requestInput = student.Id + student.Password__c + getTime;
        
        Blob requestBlob = Blob.valueOf(requestInput);
        Blob hash = Crypto.generateDigest('MD5', requestBlob);
        String token = EncodingUtil.convertToHex(hash);
        
        return token;
    }

    public static void setCookies(String secret){
        Cookie session = new Cookie('identificator', secret, null, -1, true);
        ApexPages.currentPage().setCookies(new Cookie[]{session});
        System.debug( 'SessionHelper.student= ' + SessionHelper.student);
        SessionHelper.student.SessionKey__c = secret;
        update SessionHelper.student;
    }
    
}

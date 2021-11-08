public with sharing class AuthenticationController {
    
    public Student__c student{get;set;} 
    public String password{get;set;}
    public String token{get;set;}
    public String studentId{get;set;}

    public AuthenticationController() {
        student = new Student__c();
        password = student.Password__c;
        studentId = student.Id;

        Cookie tokenCookie = ApexPages.currentPage().getCookies().get('tokenCookie');
    
        
        if (tokenCookie == null) {
            tokenCookie = new Cookie('tokenCookie','1',null,-1,true);
        } else {
        
            String tokenCookie = String.valueOf(tokenCookie.getValue());
            tokenCookie = new Cookie('tokenCookie', String.valueOf(tokenCookie+1),null,-1,true);
        }
    
        
        ApexPages.currentPage().setCookies(new Cookie[]{tokenCookie});
    }

    public String generateToken(){
        String getTime = string.valueOf(Datetime.Now().getTime()/1000); 
        String requestInput = studentId + password + getTime;
        
        Blob requestBlob = Blob.valueOf(requestInput);
        Blob hash = Crypto.generateDigest('MD5', requestBlob);
        String requestSignature = EncodingUtil.convertToHex(hash);
        token = requestSignature;
        return token;
    }

    public String setCookie(){
        
    }

}

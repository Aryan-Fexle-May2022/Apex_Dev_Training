/**
	Description 	:   Contact Detail Controller Class For promiseInLwc Component.
	Created BY 		:   Aryan Sharma
	Created Date 	:  	02-09-2022
	Revision Logs 	: 	V_1.0 - Created
**/
public class ContactDetailController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactDetails(Id recordId){
        return [ SELECT Id, Name FROM Contact WHERE Id =: recordId];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactDetail(){
        return [ SELECT Id, Name FROM Contact LIMIT 5];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> findContacts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, Title, Phone, Email, Picture__c
            FROM Contact WHERE Name LIKE :key AND Picture__c != NULL
            WITH SECURITY_ENFORCED LIMIT 10];
    }
    @AuraEnabled
    public static string getTextMethod1(){
        return 'APEX-METHOD-1';
    }
    @AuraEnabled
    public static string getTextMethod2(){
        return 'APEX-METHOD-2';
    }
    @AuraEnabled
    public static string getTextMethod3(){
        return 'APEX-METHOD-3';
    }
}
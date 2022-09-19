/**
	Description 	:   Parent Child Web Controller Class For ParentWebComponent Component.
	Created BY 		:   Aryan Sharma
	Created Date 	:  	06-09-2022
	Revision Logs 	: 	V_1.0 - Created
**/
public with sharing class ParentChildWebComponentController {
    @AuraEnabled
    public static String addData(String payload){
        Data payloadObject = (Data) JSON.deserialize(payload, Data.class);
        SObject data = (Sobject) Type.forName('Form__c').newInstance();
        data.put('Name', payloadObject.fName +' '+ payloadObject.lName);
        data.put('First_Name__c', payloadObject.fName);
        data.put('Last_Name__c', payloadObject.lName);
        data.put('Phone_Number__c', payloadObject.pNumber);
        data.put('Address__c', payloadObject.address);
        if(data != null){
            insert data;
        }
        return String.valueOf(data.Id);
    }
    //Wrapper Class to represent a ToDo Item
    public class Data {
        @AuraEnabled
        public String fName;
        @AuraEnabled
        public String lName;
        @AuraEnabled
        public integer pNumber;
        @AuraEnabled
        public String address;
    }
}
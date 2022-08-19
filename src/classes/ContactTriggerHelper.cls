/**
	Description 	:   Contact Trigger Helper Class for for Contact_rigger. 
						Practicing Duplicate Record Trigger Example.
						Sync Contact with related Account and Property.
	Created BY 		:   Aryan Sharma
	Created Date 	:  	27-07-2022
	Revision Logs 	: 	V_1.0 - Created
						V_1.1 - Dev Name : Aryan Sharma
								Date 	 : 10-08-2022
**/
public class ContactTriggerHelper {
    public static void checkDuplicateEmail(List<Contact> conNewList, Map<Id,Contact> conOldMap) {
        //Set of new Email Set from Trigger.New
        Set<String> newEmailSet = new Set<String>();
        //Set of Existing Email
        Set<String> existingEmailSet = new Set<String>();
        // Filling the new Email Set from Trigger.New(conNewList)
        for(Contact newCon : conNewList) {
            if(newCon.Email != null && (conOldMap == null || newCon.Email != conOldMap.get(newCon.Id).Email)) {
                newEmailSet.add(newCon.Email);
            }
        }
        // Performing SOQL on Contact to get Email(Duplicate records) on the Basis of newEmailSet
        if(!newEmailSet.isEmpty()){
            List<Contact> existingContList = [SELECT Id, Name, Email FROM Contact 
                                              WHERE Email IN : newEmailSet AND Email != null];
            //if any any record exits with same Email then add to existingEmailSet
            if(!existingContList.isEmpty()) {
                for(Contact con : existingContList) {
                    existingEmailSet.add(con.Email);
                }
                //Now iterate over Trigger.New to check whether existingEmailSet contains Trigger.New Lists Email
                if(!existingEmailSet.isEmpty()) {
                    for(Contact con : conNewList) {
                        if(existingEmailSet.contains(con.Email)) {
                            con.Email.addError('Email is already exists, Please change it!, Duplicate Record!');
                        }
                    }
                }
            }
        }
    }  
    // Assignment Day 23 --> Sync Contact Status field with Related Account and Property
    public static void syncContactWithAccountAndProperty(List<Contact> newContactList){
        Set<Id> accountIdSet = new Set<Id>();
        Set<Id> propertyIdSet = new Set<Id>();
        Map<Id, Account> mapOfIdwithAccount = new Map<Id, Account>();
        Map<Id, Property__c> mapOfIdwithProperty = new Map<Id, Property__c>();
        List<Contact> conList = new List<Contact>();
        for(Contact newCont : newContactList){
            if(newCont.Status__c == null){
                accountIdSet.add(newcont.AccountId);
                conList.add(newCont); // add contact whose status is null
            }
        }
        System.debug(accountIdSet+'<---accountIdSet');
        if(!accountIdSet.isEmpty()){
            List<Account> accountList = [SELECT Id, Name, Status__c, Property__c, Property__r.Status__c 
                                         FROM Account WHERE Id In : accountIdSet];
            for(Account acc : accountList){
                mapOfIdwithAccount.put(acc.Id, acc);
            }
            System.debug(accountList+'<---accountList');
            System.debug(mapOfIdwithAccount+'<---mapOfIdwithAccount');
            if(!accountList.isEmpty()){
                for(Contact con : conList) {
                    if(mapOfIdwithAccount.get(con.AccountId).Status__c != null){
                        con.Status__c = mapOfIdwithAccount.get(con.AccountId).Status__c;
                    }
                    else {
                        propertyIdSet.add(mapOfIdwithAccount.get(con.AccountId).Property__c);
                    }
                }
                System.debug(propertyIdSet+'<--propertyIdSet');
                if(!propertyIdSet.isEmpty()){
                    List<Property__c> propertyList = [SELECT Id, Name, Status__c FROM Property__c 
                                                      WHERE Id In : propertyIdSet];
                    
                    for(Property__c prop : propertyList){
                        mapOfIdwithProperty.put(prop.Id, prop);
                    }
                    System.debug(propertyList+'<--propertyList');
                    System.debug(mapOfIdwithProperty+'<--mapOfIdwithProperty');
                    if(!propertyList.isEmpty()){
                        for(Contact con : conList) {
                            if(mapOfIdwithProperty.get(mapOfIdwithAccount.get(con.AccountId).Property__c).Status__c != null){
                                mapOfIdwithAccount.get(con.AccountId).Status__c =
                                    mapOfIdwithProperty.get(mapOfIdwithAccount.get(con.AccountId).Property__c).Status__c;
                                con.Status__c = mapOfIdwithAccount.get(con.AccountId).Status__c;
                            }
                        }
                    }
                }  
            }
            if(!mapOfIdwithAccount.isEmpty()) {
                update mapOfIdwithAccount.values();
            }
        }
    }
}
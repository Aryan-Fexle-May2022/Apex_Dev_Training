/**
Description :   Helper Class For Contact_Trigger
Created BY :    Aryan Sharma
Created Date :  27-07-2022
Revision Logs : V_1.0 - Created 								  
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
}
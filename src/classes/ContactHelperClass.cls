/**
    Description :   Helper Class For Contact_Trigger
    Created BY :    Aryan Sharma
    Created Date :  27-07-2022
    Revision Logs : V_1.0 - Created 								  
**/
public class ContactHelperClass {
    public static void emailInsertRecord(List<Contact> conNewList) {
        //Set of new Email Set from Trigger.New
        Set<String> newEmailSet = new Set<String>();
        //Set of Existing Email
        Set<String> existingEmailSet = new Set<String>();
        // Filling the new Email Set from Trigger.New(conNewList)
        for(Contact newCon : conNewList) {
            if(newCon.Email != null) {
                newEmailSet.add(newCon.Email);
            }
        }
        // Performing SOQL on Contact to get Email(Duplicate records) on the Basis of newEmailSet 
        // if we have new Email(abc@mail.com, xyz@mail.com) and if we do not filter this query 
        // then it gives us all Contact records which is in our system(Like - 10000)
        // but now it will give us 0 Records bcoz no record exits till now with above email
        List<Contact> existingContList = [SELECT Id, Name, Email FROM Contact 
                                          WHERE Email IN : newEmailSet];
        //if any any record exits with same Email then add to existingEmailSet
        for(Contact con : existingContList) {
            existingEmailSet.add(con.Email);
        }
        //Now iterate over Trigger.New to check whether existingEmailSet contains Trigger.New Lists Email
        for(Contact con : conNewList) {
            if(existingEmailSet.contains(con.Email)) {
                con.Email.addError('Email is already exists, Please change it!, Duplicate Record!');
            }
        } 
    }
    public static void emailUpdateRecord(List<Contact> conNewList, Map<Id,Contact> conOldMap) {
        //Set of new Email Set from Trigger.New
        Set<String> newEmailSet = new Set<String>();
        //Set of Existing Email
        Set<String> existingEmailSet = new Set<String>();
        // Filling the new Email Set from Trigger.New(conNewList)
        for(Contact newCon : conNewList) {
            //This (newCon.Email != oldCon.Email) statement is used to restrict the updation
            // whenever any other field is also updated so we must use this 
            // and map is used to lower the number of iteration in for loop instead of OldList
            if(newCon.Email != null && newCon.Email != conOldMap.get(newCon.Id).Email) {
                newEmailSet.add(newCon.Email);
            }
        }
        // Performing SOQL on Contact to get Email(Duplicate records) on the Basis of newEmailSet 
        // if we have new Email(abc@mail.com, xyz@mail.com) and if we do not filter this query 
        // then it gives us all Contact records which is in our system(Like - 10000)
        // but now it will give us 0 Records bcoz no record exits till now with above email
        List<Contact> existingContList = [SELECT Id, Name, Email FROM Contact 
                                          WHERE Email IN : newEmailSet];
        //if any any record exits with same Email then add to existingEmailSet
        for(Contact con : existingContList) {
            existingEmailSet.add(con.Email);
        }
        //Now iterate over Trigger.New to check whether existingEmailSet contains Trigger.New Lists Email
        for(Contact con : conNewList) {
            if(existingEmailSet.contains(con.Email)) {
                con.Email.addError('Email is already exists, Please change it!, Duplicate Record!');
            }
        }
    }  
}
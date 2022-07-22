/**
    Description :   Bank_Account_Trigger for trigger an sObject
                    Inserting Account Number
                    Sending Mail after creating Account
                    Sending Mail after Deactivating Account
    Created BY :    Aryan Sharma
    Created Date :  20-07-2022
    Revision Logs : V_1.0 - Created 								  
**/
trigger Bank_Account_Trigger on Bank_Account__c (before insert, after insert,after delete) {
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            for(Bank_Account__c accNewList : Trigger.New) { 
                BankAccountHelper.insertAccountNumber(Trigger.New);
            }
        }
    }
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            for(Bank_Account__c accNewList : Trigger.New) {
                BankAccountHelper.sendEmailNotificationWhenAccountCreate(Trigger.New);
            }
        }
        if(Trigger.isDelete) {
            for(Bank_Account__c accOldList : Trigger.old) {
                BankAccountHelper.sendEmailNotificationWhenAccountDelete(Trigger.Old);
            }
        }
    }
}
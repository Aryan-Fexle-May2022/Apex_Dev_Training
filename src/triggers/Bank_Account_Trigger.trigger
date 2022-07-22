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
            BankAccountHelper.insertAccountNumber(Trigger.New);
        }
    }
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            BankAccountHelper.sendEmailNotificationWhenAccountCreate(Trigger.New);
        }
        if(Trigger.isDelete) {
            BankAccountHelper.sendEmailNotificationWhenAccountDelete(Trigger.Old);
        }
    }
}
/**
    Description :   Contact_Trigger for trigger on Contact Object
                    Practicing Duplicate Record Trigger Example
    Created BY :    Aryan Sharma
    Created Date :  27-07-2022
    Revision Logs : V_1.0 - Created 								  
**/
trigger Contact_Trigger on Contact (before insert,before update, after undelete) {
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            ContactHelperClass.emailInsertRecord(Trigger.New);
        }
        if(Trigger.isUpdate) {
            ContactHelperClass.emailUpdateRecord(Trigger.New, Trigger.oldMap);
        }
    }
}
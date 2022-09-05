/**
	Description 	:   Contact_Trigger for trigger on Contact Object
						Practicing Duplicate Record Trigger Example
						Sync Contact with related Account and Property
	Created BY 		:   Aryan Sharma
	Created Date 	:  	27-07-2022
	Revision Logs 	: 	V_1.0 - Created
						V_1.1 - Dev Name : Aryan Sharma
								Date 	 : 10-08-2022
**/
trigger Contact_Trigger on Contact (before insert,before update) {
    if(Trigger.isBefore) {
        if(Trigger.isInsert || Trigger.isUpdate) {
            ContactTriggerHelper.checkDuplicateEmail(Trigger.New, Trigger.oldMap);
            ContactTriggerHelper.syncContactWithAccountAndProperty(Trigger.New);
        }
    }
}
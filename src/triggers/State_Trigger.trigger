/**
	Description 	:   State_Trigger for trigger on State Object.
						Updating total_district and Json Data on Country
						when inserting, updating or deleting State.
	Created BY 		:   Aryan Sharma
	Created Date 	:  	08-08-2022
	Revision Logs 	: 	V_1.0 - Created
**/
trigger State_Trigger on State__c (after insert, after update, after delete) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert || Trigger.isUpdate ){
            StateTriggerHelper.populateCountryRecords(Trigger.New, Trigger.old);
        }
        else if(Trigger.isDelete) {
            StateTriggerHelper.populateCountryRecords(Trigger.New, Trigger.old);
        }
    }
}
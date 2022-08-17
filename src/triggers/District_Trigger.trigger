/**
	Description 	:   District_Trigger for trigger on District Object.
						Updating total_states, total_district and Json Data on State and Country
						when inserting, updating or deleting District.
	Created BY 		:   Aryan Sharma
	Created Date 	:  	08-08-2022
	Revision Logs 	: 	V_1.0 - Created
**/
trigger District_Trigger on District__c (after insert, after update, after delete) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert || Trigger.isUpdate ) {
            DistrictTriggerHelper.populateCountryStateRecords(Trigger.New, Trigger.old);
        }
        else if(Trigger.isDelete  ) {
            DistrictTriggerHelper.populateCountryStateRecords(Trigger.New, Trigger.old);
        }
    }
}
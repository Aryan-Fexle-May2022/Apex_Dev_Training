/**
	Description :   Contact_Trigger for trigger on Opportunity Object
					Populating Automobile records
	Created BY :    Aryan Sharma
	Created Date :  29-07-2022
	Revision Logs : V_1.0 - Created 								  
**/
trigger Opportunity_Trigger on Opportunity (after insert, after update) 
{
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate) {
            OpportunityTriggerHelper.populateAutomobileSensorRecords(Trigger.New, Trigger.oldMap);	
            OpportunityTriggerHelper.sendEmail(Trigger.New);	
        }
    }
}
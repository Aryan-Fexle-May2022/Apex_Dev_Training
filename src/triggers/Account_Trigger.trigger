/**
    Description :   Account_Trigger for trigger on Account Object
                    Practicing all Trigger Events in differ-differ Scenerio
    Created BY :    Aryan Sharma
    Created Date :  22-07-2022
    Revision Logs : V_1.0 - Created 								  
**/
trigger Account_Trigger on Account (before insert,before update,before delete,
                                    after insert, after update, after delete, after undelete) 
{
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            System.debug('I am before insert trigger on Account Object');
            AccountTriggerHelper.beforeInsertMethod1(Trigger.New);   
            AccountTriggerHelper.beforeInsertMethod2(Trigger.New);
        }
        else if(Trigger.isUpdate) {
            System.debug('I am before update trigger on Account Object'); 
            AccountTriggerHelper.beforeUpdateMethod1(Trigger.New , Trigger.Old);
        }
        else if(Trigger.isDelete) {
            System.debug('I am before delete trigger on Account Object');
            AccountTriggerHelper.beforeDeleteMethod1(Trigger.Old);
        }
    }
    else if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            System.debug('I am after insert trigger on Account Object');
            AccountTriggerHelper.afterInsertMethod1(Trigger.New);            }
        else if(Trigger.isUpdate) {
            System.debug('I am after update trigger on Account Object');
            AccountTriggerHelper.afterUpdateMethod1(Trigger.New , Trigger.Old);
            AccountTriggerHelper.calculateBalance(Trigger.Old);
        }
        else if(Trigger.isDelete) {
            System.debug('I am after delete trigger on Account Object');
            AccountTriggerHelper.afterDeleteMethod1(Trigger.Old);
        }
        else if(Trigger.isUndelete) {
            System.debug('I am after Undelete trigger on Account Object');
            AccountTriggerHelper.afterUndeleteMethod1(Trigger.New);
        }
    }
}
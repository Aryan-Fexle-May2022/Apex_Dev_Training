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
            AccountHelperClass.beforeInsertMethod1(Trigger.New);   
            AccountHelperClass.beforeInsertMethod2(Trigger.New);
        }
        else if(Trigger.isUpdate) {
            System.debug('I am before update trigger on Account Object'); 
            AccountHelperClass.beforeUpdateMethod1(Trigger.New , Trigger.Old);
        }
        else if(Trigger.isDelete) {
            System.debug('I am before delete trigger on Account Object');
            AccountHelperClass.beforeDeleteMethod1(Trigger.Old);
        }
    }
    else if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            System.debug('I am after insert trigger on Account Object');
            AccountHelperClass.afterInsertMethod1(Trigger.New);            }
        else if(Trigger.isUpdate) {
            System.debug('I am after update trigger on Account Object');
            AccountHelperClass.afterUpdateMethod1(Trigger.New , Trigger.Old);
            AccountHelperClass.calculateBalance(Trigger.Old);
        }
        else if(Trigger.isDelete) {
            System.debug('I am after delete trigger on Account Object');
            AccountHelperClass.afterDeleteMethod1(Trigger.Old);
        }
        else if(Trigger.isUndelete) {
            System.debug('I am after Undelete trigger on Account Object');
            AccountHelperClass.afterUndeleteMethod1(Trigger.New);
        }
    }
}
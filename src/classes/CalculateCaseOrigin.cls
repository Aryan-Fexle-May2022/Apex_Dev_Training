/**
    Description     :   CalculateCaseOrigin Class, Here I used future Method implementation.
                        Here, Update Account records field acccourding to Cases Origin(Email,
                        Phone, Web) and udpate count on Account field Mail, Phone, Web.
    Created BY      :   Aryan Sharma
    Created Date    :   22-08-2022
    Revision Logs   :   V_1.0 - Created
**/
public with sharing class CalculateCaseOrigin {
    @future
    public static void countCasesBasedOnOrigin(List<ID> accIdList){
        List<Account> accList = [SELECT ID, Cases_through_Email__c, Cases_through_Phone__c, 
                                Cases_through_Web__c, (SELECT ID, Origin FROM Cases) FROM Account 
                                WHERE ID IN : accIdList];
        for(Account acc : accList){
            Integer phone, email, web;
            for(Case caseRecord : acc.Cases){
                if(caseRecord.Origin == 'Phone'){
                    phone++;
                }
                else if(caseRecord.Origin == 'Email'){
                    email++;
                }
                else if(caseRecord.Origin == 'Web'){
                    web++;
                }
            }
            acc.Cases_through_Phone__c = phone;
            acc.Cases_through_Email__c = email;
            acc.Cases_through_Web__c = web;
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
}

/**
    Description     :   CalculateCaseOrigin Test Class.
    Created BY      :   Aryan Sharma
    Created Date    :   22-08-2022
    Revision Logs   :   V_1.0 - Created
**/
@IsTest
public with sharing class CalculateCaseOriginTest {
    @IsTest
    static void test(){
        List<Account> accList = new List<Account>();
        List<Id> accIds = new List<Id>();
        for(Integer i=1;i<=200;i++){
            accList.add(new Account(Name='Account'+i));
        }
        if(!accList.isEmpty()){
            insert accList;
        }
        for(Account acc : accList){
            accIds.add(acc.Id);
        }
        Test.startTest();
        CalculateCaseOrigin.countCasesBasedOnOrigin(accIds);
        Test.stopTest();
        System.assertEquals(200, [SELECT COUNT() FROM Account WHERE Name LIKE : 'Account%']);
    }
}

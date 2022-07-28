/**
    Description :   Helper Class For Account_Trigger
    Created BY :    Aryan Sharma
    Created Date :  22-07-2022
    Revision Logs : V_1.0 - Created 								  
**/
public class AccountHelperClass {
    //Scenerio 1 : prepopulating Shipping Address from Billing Address
    //Before Insert Trigger
    public static void beforeInsertMethod1(List<Account> accList) {
        for(Account acc : accList) {
            if(acc.ShippingCity == null &&  acc.ShippingState == null &&  
               acc.ShippingCountry == null &&  acc.ShippingPostalCode == null 
               &&  acc.ShippingStreet == null) 
            {
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingState = acc.BillingState;
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingStreet = acc.BillingStreet;
            }
            else {
                acc.addError('Hey, your Shiiping Address is differ from Billing Address');
            }
        }
    }
    //Scenerio 2 : Gives Error if Annual Revenue seems to be less than 1K
    //Before Insert Trigger
    public static void beforeInsertMethod2(List<Account> accList) {
        for(Account acc : accList) {
            if(acc.AnnualRevenue < 1000) {
                acc.addError('Look onto Annual Revenue,it seems to low.It should be more than 10k');
            }
        }
    }
    
    //Scenerio 3 : Creating account record along with the Contact in 
    //which the Name of Contact is same as account Name
    //and also same billing street address
    //and associate Account and Contact(means same Id)
    //After Insert Trigger
    public static void afterInsertMethod1(List<Account> accList) {
        List<Contact> conListtoInsert = new List<Contact>();
        for(Account accRec : accList) {
            Contact con = new Contact();
            con.LastName = accRec.Name;
            con.MailingStreet = accRec.BillingStreet;
            con.AccountId = accRec.Id;
            conListtoInsert.add(con);
        }
        //update the Contact List which is associated with Account
        if(conListtoInsert.size() >0) {
            insert conListtoInsert;
        }
    }
    //Scenerio 4 : Updating account record, if user changes Account Name through an Error
    //Before Update Trigger
    public static void beforeUpdateMethod1(List<Account> accNewList,List<Account> accOldList) {
        for(Account acc1 : accOldList) {
            for(Account acc2 : accNewList) {
                if(acc1.Name != acc2.Name && acc1.Id == acc2.Id) {
                    acc2.addError('Account Name once created cannot be modified');
                }
            }            
        }
    }
    //Scenerio 5 : Updating account record,if Billing Address is changed update all its 
    //cild contacts Mailing Address field same as account Billing Address
    //After update Trigger
    public static void afterUpdateMethod1(List<Account> accNewList, List<Account> accOldList) {
        Set<Id> accIdsWhichGotBillingAddressChanged = new Set<Id>();
        for(Account accRecNew : accNewList) {
            for(Account accRecOld : accOldList) {
                if(accRecNew.Id == accRecOld.Id && accRecNew.BillingStreet != accRecOld.BillingStreet) {
                    accIdsWhichGotBillingAddressChanged.add(accRecNew.Id);
                }
            }
        }
        //This Set accIdsWhichGotBillingAddressChanged will have acountIds which 
        //got billing address changed
        List<Account> accWithContacts = [SELECT Id, Name, BillingCity, BillingStreet, 
                                         BillingState, BillingCountry, (SELECT Id, Name FROM Contacts) 
                                         From Account WHERE Id IN : accIdsWhichGotBillingAddressChanged];
        List<Contact> conListtoUpdate = new List<Contact>();
        for(Account acc : accWithContacts) {
            List<Contact> conOfTheLoopedAccount = acc.contacts;
            for(Contact con : conOfTheLoopedAccount)
            {
                con.MailingCity = acc.BillingCity;
                con.MailingCountry = acc.BillingCountry;
                con.MailingState = acc.BillingState;
                con.MailingStreet = acc.BillingStreet;
                conListtoUpdate.add(con);
            }
        }
        if(conListtoUpdate.size() >0) {
            update conListtoUpdate;
        }
    } 
    //Scenerio 6 : An active account should not be delete, means if Active field status is 
    //Yes then that account should not be deleted and then fire a Error
    //Before Delete Trigger
    public static void beforeDeleteMethod1(List<Account> accOldList){
        for(Account accOldRec : accOldList) {
            if(accOldRec.Active__c == 'Yes') {
                accOldRec.addError('You cannot delete an active account');
            }
        }
    }
    //Scenerio 7 : Whenever user deletes account, Send an confirmation mail to the user
    //After delete Trigger
    public static void afterDeleteMethod1(List<Account> accOldList) {
        List<Messaging.Email> emailObjList = new List<Messaging.Email>();
        for(Account accRec : accOldList) {
            Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[]{'aryan.sharma@fexle.com'};
            emailObj.setToAddresses(toAddresses);
            emailObj.setSenderDisplayName('Aryan Sharma');
            emailObj.setSubject('Account has been successfully deleted ' + accRec.Name);
            emailObj.setPlainTextBody('Hello '+accRec.Name+', '+'Your Account has been deleted.');
            emailObjList.add(emailObj);
        }
        // Send the email you have created. sendMail() is a method
        Messaging.sendEmail(emailObjList);
    }
    //Scenerio 8 : Send an confirmation mail to the user, When a user restores 
    //an account from recycle bin
    //After undelete Trigger
    public static void afterUndeleteMethod1(List<Account> accNewList) {
        List<Messaging.Email> emailObjList = new List<Messaging.Email>();
        for(Account accRec : accNewList) {
            Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[]{'aryan.sharma@fexle.com'};
            emailObj.setToAddresses(toAddresses);
            emailObj.setSenderDisplayName('Aryan Sharma');
            emailObj.setSubject('Account has been successfully Restored ' + accRec.Name);
            emailObj.setPlainTextBody('Hello '+accRec.Name+', '+'Your Account has been restrored now.');
            emailObjList.add(emailObj);
        }
        // Send the email you have created. sendMail() is a method
        Messaging.sendEmail(emailObjList);
    }
    //Scenerio 9 : This method equally divide the ammount stored in custom field Balance__c 
    //of Accounts into Individual_Balance__c field assosiated Contacts.
    // Use after update here 
    public static void calculateBalance(List<Account> accOldList) {
        List<Account> accList = [SELECT Id, Name, Balance__c,
                                 (SELECT Id, Name, Individual_Balance__c FROM Contacts)
                                 FROM Account WHERE Balance__c>0];
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList) {
            if(acc.Contacts.size() > 0) {
                Decimal dividedBalance = acc.Balance__c/acc.Contacts.size();
                for(Contact con : acc.Contacts) {
                    con.Individual_Balance__c = dividedBalance;
                    conList.add(con);
                }
            }
        }
        if(conList.size() > 0) {
            update conList;
        }
    }
}
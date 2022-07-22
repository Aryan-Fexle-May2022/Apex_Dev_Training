/**
    Description : Purpose - Helper Class For Bank_Account_Trigger
    Created BY : Aryan Sharma
    Created Date : 20-07-2022
    Revision Logs : V_1.0 - Created 								  
**/
public class BankAccountHelper {
    //Inserting Account Number
    public static void insertAccountNumber(List<Bank_Account__c> accList) {
        for(Bank_Account__c accNewRec : accList) {
            if(accNewRec.Type__c == 'Savings Account' ) {
                accNewRec.Bank_Account_Number__c = 'SA-' + accNewRec.Bank_Account_Number__c;
            }
            else if(accNewRec.Type__c == 'Current Account' ) {
                accNewRec.Bank_Account_Number__c = 'CA-' + accNewRec.Bank_Account_Number__c;
            }
            else if(accNewRec.Type__c == 'Recurring Deposit Account' ) {
                accNewRec.Bank_Account_Number__c = 'RDA-' + accNewRec.Bank_Account_Number__c;
            }
            else if(accNewRec.Type__c == 'Fixed Deposit Account' ) {
                accNewRec.Bank_Account_Number__c = 'FDA-' + accNewRec.Bank_Account_Number__c;
            }
            else if(accNewRec.Type__c == 'DEMAT Account' ) {
                accNewRec.Bank_Account_Number__c = 'DA-' + accNewRec.Bank_Account_Number__c;
            }
            else if(accNewRec.Type__c == 'NRI Account' ) {
                accNewRec.Bank_Account_Number__c = 'NA-' + accNewRec.Bank_Account_Number__c;
            }
        }
    }
    //Sending Mail after an Account created
    public static void sendEmailNotificationWhenAccountCreate(List<Bank_Account__c> acctList) {
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        for(Bank_Account__c acct : acctList) {
            if(acct.Account_Holder_s_Email__c != null) {
                //Insitialization to mailing method
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage(); 
                String[] toAddress = new String[]{acct.Account_Holder_s_Email__c};
                    emailMsg.setToAddresses(toAddress);
                String emailSub = 'Welcome to '+acct.Bank_Name__c+'!'; //Email Subject
                emailMsg.setSubject(emailSub);
                String disName = 'Aryan Sharma'; //Display Name
                emailMsg.setSenderDisplayName(disName);
                //Content or Body of the Email
                String content = acct.Date__c+' <br/><br/>' +  
                    'Congratulations 🎉🎊 <br/><br/>' +
                    'Dear '+acct.Name+', <br/><br/>' +
                    'Welcome to '+acct.Bank_Name__c+ ' <br/><br/>' +
                    'Your ' + acct.Type__c+ ' no. '+acct.Bank_Account_Number__c+ ' is active <br/><br/>'+
                    'Should you have any queries, Please call 18605005555. <br/><br/>' +
                    'Always open to help you <br/><br/>' + 
                    'Regards, <br/><br/>' +
                    acct.Bank_Name__c+ ' <br/><br/>' ;
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);  
            }
        }
        //Send the email what we have created
        Messaging.sendEmail(emailList);
    }
    //Sending Mail after an Account Deleted
    public static void sendEmailNotificationWhenAccountDelete(List<Bank_Account__c> acctList) {
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        for(Bank_Account__c acct : acctList) {
            if(acct.Account_Holder_s_Email__c != null) {
                //Insitialization to mailing method
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage(); 
                String[] toAddress = new String[]{acct.Account_Holder_s_Email__c};
                emailMsg.setToAddresses(toAddress);
                String emailSub = acct.Bank_Name__c+'!'+' Bank Account Deactivated '; //Email Subject
                emailMsg.setSubject(emailSub);
                String disName = 'Aryan Sharma'; //Display Name
                emailMsg.setSenderDisplayName(disName);
                //Content or Body of the Email
                String content = acct.Date__c+' <br/><br/>' +  
                    'Dear '+acct.Name+', <br/><br/>' +
                    'Your ' + acct.Type__c+ ' no. '+acct.Bank_Account_Number__c+ ' is now deactive <br/><br/>'+
                    'Should you have any queries, Please call 18605005555. <br/><br/>' +
                    'Always open to help you <br/><br/>' + 
                    'Regards, <br/><br/>' +
                    acct.Bank_Name__c+ ' <br/><br/>' ;
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);  
            }
        }
        //Send the email what we have created
        Messaging.sendEmail(emailList);
    }
}
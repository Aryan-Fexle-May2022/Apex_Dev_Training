// Converting to the ContactLeadAccount
public with sharing class WorkingWithsObjects {
    List<Contact> contacts = new List<Contact>();
    List<Lead> leads = new List<Lead>();
    List<Account> accounts = new List<Account>();

    public void convertType(String phoneNumber) {
        List<List<SObject>> results = [FIND :phoneNumber 
        IN Phone FIELDS 
        RETURNING Contact(Id, Phone, FirstName, LastName), 
        Lead(Id, Phone, FirstName, LastName), 
        Account(Id, Phone, Name)];

        List<SObject> records = new List<SObject>();
        records.addAll(results[0]); //add Contact results to our results super-set
        records.addAll(results[1]); //add Lead results
        records.addAll(results[2]); //add Account results

        if (!records.isEmpty()) { 
            for (Integer i = 0; i < records.size(); i++) { 
            SObject record = records[i];
                if (record.getSObjectType() == Contact.sObjectType) { 
                    contacts.add((Contact) record);
                }
                else if (record.getSObjectType() == Lead.sObjectType){ 
                    leads.add((Lead) record);
                } 
                else if (record.getSObjectType() == Account.sObjectType) { 
                    accounts.add((Account) record); 
                }
            }
        }       
    }
}


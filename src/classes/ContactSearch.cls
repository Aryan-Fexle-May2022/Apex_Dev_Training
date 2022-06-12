public class ContactSearch {
    public static List<Contact> searchForContact(string s1, string s2) {
        List<Contact> conList = [SELECT Id,Name FROM Contact WHERE LastName= :s1 AND MailingPostalCode= :s2];
        
        return conList;
    }
}
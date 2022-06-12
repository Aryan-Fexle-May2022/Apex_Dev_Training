public class StudentManager {
    
    // Insert Student records
    public void insertRecord() {
        Student__c student = new Student__c();
        // Student Information
        student.First_Name__c = 'Aryan';
        student.Last_Name__c = 'Khandelwal';
        student.Male__c = True;
        student.Famale__c = False;
        student.Current_Semester__c = 7;
        //student.Year_Of_Class__c = '2022';
        //student.Latitude__c = '10';
        //student.Longitude__c = '10';
        student.Date_Of_Birth__c = Date.newInstance(2008,11,20);
        
        // Student Personal Information
        student.Name = 'Aryan Khandelwal';
        student.Roll_Number__c = 121;
        student.Father_Name__c = 'Sitaram Sharma';
        student.Email__c = 'js123@gmail.com';
        student.Personal_Mobile_Number__c = '874549878';
        student.Father_Mobile_Number__c =  '874529878';
        student.Overall_Grade_Percentage__c = 86;
        student.HomePhone__c = '114571525';
        student.Address__c = 'Sikar';
        student.LinkedIn_Account__c = 'https://www.linkedin.com/in/aryan-sharma-357bb41ab/';
        
        // Class Info
        student.Section_Stream__c = 'Computer Science & Eng.';
        student.Section__c = 'A';
        
        // Fees Details
        student.Current_Year__c = 4;
        student.Pending_Fees_Amount__c = 0;
        student.Pending_Exam_Fees__c = 0;
        student.Fees_Submitted__c = 'YES';
        student.Exam_Fees_Submitted__c = 'YES';
        student.Is_Donation__c = 'NO';
        student.Donation_Amount__c = 0;
        student.Pending_Overall_Amount__c = 0;
        
        // Semester Details
        student.Back_In_Which_Sem__c = 'NA';
        student.Back_In_Which_Subject__c = 'NA';
        
        // Bank details
        student.Bank_Name__c = 'AXIS Bank';
        student.Bank_Phone_Number__c = '9516573289';
        student.Account_Number__c = 958995923;
        student.IFSC_Code__c = 'AXIS648486998';
        student.City__c = 'Sikar';
        student.State__c = 'Rajasthan';
        student.Mobile_Number__c = '9899848741';
        
        //insert student;
        
        //Query 1 Students
        List<Student__c> studentList = [SELECT id, name, Roll_Number__c FROM Student__c ORDER BY createdDate ASC LIMIT 5];
        for(Student__c iterateRecord : studentList){
            system.debug('Check Student Data ::: ' + iterateRecord);
        }
    }
}
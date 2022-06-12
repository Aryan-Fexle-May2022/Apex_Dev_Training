public class EmployeeRecords {
    public EmployeeRecords() {
        //Insert Employee Records
        Employee__c employee = new Employee__c();
        employee.Name = 'Aryan Sharma';
        employee.First_Name__c = 'Aryan';
        employee.Last_Name__c = 'Sharma';
        employee.Project__c = 'Proj';
        employee.Email__c = 'as123@gmail.com';
        
        insert employee;
        
    }
    
}
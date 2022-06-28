public class HierarchicalCollectionExample {
    public HierarchicalCollectionExample() {
        Student__c student = new Student__c();
        Map<String, Map<String, List<student>>> yogaClassMap = new Map<String, Map<String, List<student>>>();
        
        //1st Year List Of Students
        List<student> Year1stListComputer = new List<student>();
        Year1stListComputer = [SELECT id, Name, Roll_Number__c, Current_Year__c, Section_Stream__c FROM Student__c
        WHERE Current_Year__c=1 AND Section_Stream__c='Computer Science & Eng.'];
        Map<String, List<student>> mapOfStudentwithStream1stYear = new Map<String, List<student>>();
        mapOfStudentwithStream1stYear.put('Computer Science', Year1stListComputer);
        
        //1st Year List Of Students
        List<student> Year1stListElectronic = new List<student>();
        Year1stListElectronic = [SELECT id, Name, Roll_Number__c, Current_Year__c, Section_Stream__c FROM Student__c 
        WHERE Current_Year__c=1 AND Section_Stream__c='Electrical Engineering'];
        //Map<String, List<Student>> mapOfStudentwithStream1stYear = new Map<String, List<Student>>();
        mapOfStudentwithStream1stYear.put('Electrical Engineering', Year1stListElectronic);
        
        //1st Year List Of Students
        List<student> Year1stListIT = new List<student>();
        Year1stListIT = [SELECT id, Name, Roll_Number__c, Current_Year__c, Section_Stream__c FROM Student__c 
        WHERE Current_Year__c=1 AND Section_Stream__c='Information Technology'];
        //Map<String, List<Student>> mapOfStudentwithStream1stYear = new Map<String, List<Student>>();
        mapOfStudentwithStream1stYear.put('Information Technology', Year1stListIT);
        
        //1st Year List Of Students
        List<student> Year1stListMechanical = new List<student>();
        Year1stListMechanical = [SELECT id, Name, Roll_Number__c, Current_Year__c, Section_Stream__c FROM Student__c 
        WHERE Current_Year__c=1 AND Section_Stream__c='Mechanical Engineering'];
        //Map<String, List<Student>> mapOfStudentwithStream1stYear = new Map<String, List<Student>>();
        mapOfStudentwithStream1stYear.put('Mechanical Engineering', Year1stListMechanical);
        
        
        yogaClassMap.put(1,mapOfStudentwithStream1stYear);
    }
}
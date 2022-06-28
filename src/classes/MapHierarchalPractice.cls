public with sharing class MapHierarchalPractice {
    public String districtName{ get; Set;}
        public String stateName{get; set;}
        public String countryName{get; set;}

        public MapHierarchalPractice(String districtName, String stateName, String countryName) {
            this.districtName = districtName;
            this.stateName = stateName;
            this.countryName = countryName;
        }
        public void mapOfMap() {
            List<MapHierarchalPractice> listt = new List<MapHierarchalPractice>(
            new MapHierarchalPractice('Jhunjhunu','Rajasthan','India'),
            new MapHierarchalPractice('Sikar','Rajasthan','India'),
            new MapHierarchalPractice('Udiapur','Rajasthan','India'),
            new MapHierarchalPractice('Solapur','Maharashtra','India'),
            new MapHierarchalPractice('Nashik','Maharashtra','India'),
            new MapHierarchalPractice('Central Delhi','Delhi','India'),
            new MapHierarchalPractice('New Delhi','Delhi','India'),
            new MapHierarchalPractice('Ahmedabad','Gujarat','India'),
            new MapHierarchalPractice('Rajkot','Gujarat','India')
            );
            
        Map<String, Map<String, List<String>>> countryMap = new Map<String, Map<String, List<String>>>();

        Map<String, List<String>> statedistrictList = new Map<String, List<String>>();
        statedistrictList.put(stateName, districtName);

        countryMap.put('India', stateName);

        System.debug('countryMap'+countryMap);
        
        }    
}

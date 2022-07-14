/**
    Description : Purpose - To give the hierarchy of Country Code, Country, State, District
                            -Filling the Map dynamically
                            -And also find the combination of these 3 which starts with 'S'
                            -And also find the those district whose length is greater and equal to 12
                            -Here JSON format is generated 
                            -We have a Constructor for Map filling and a method for JSON generator
							-Updating the JSON data to database(Text area field)
    Created BY : Aryan Sharma
    Created Date : 11-07-2022
    Revision Logs : V_1.0 - Created
**/
public with sharing class CountryStateJSonGenerator {
    List<District__c> listDistrict = new List<District__c>();
    List<State__c> listState = [SELECT Name, Country__r.Name, 
                                Country__r.Country_Code__c, 
                                Country__r.Total_Number_Of_Districts__c, 
                                Country__r.Total_Number_Of_States__c, 
                                Country__r.Country_Json_Data__c FROM State__c] ;
    List<Country__c> listCountry = new List<Country__c>();
    Map<String, Map<String, List<String>>> mapCountryAndStateWithDistricts = 
        new Map<String, Map<String, List<String>>>();
    
    //These are the Wrapper Class for JSON
    Public List<Country> countryList{get; set;}
    public class Country{
        public String countryName{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
        public Integer Total_Number_Of_States{get; set;}
        public List<States> states{get; set;} 
    }
    public class States{
        Public List<Districts> districts{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
        Public String stateName{get; set;}
    }
    public class Districts {
        Public String districtName{get; set;}
    }
    
    public CountryStateJSonGenerator(String startingKeyword) { 
        listDistrict = [SELECT Id, Name, State__c, State__r.Name, 
                        State__r.Total_Number_Of_Districts__c, 
                        State__r.State_Code__c, State__r.Country__c, 
                        State__r.Country__r.Name, 
                        State__r.Country__r.Country_Code__c, 
                        State__r.Country__r.Total_Number_Of_Districts__c, 
                        State__r.Country__r.Total_Number_Of_States__c, 
                        State__r.Country__r.Country_Json_Data__c FROM District__c ];
        //System.debug(listDistrict);
      
        // 1. Fining the combination of the Country,State and District 
        // Which starts with Any Specified Keyword
        try {
            List<String> listOfStateAndDistrict = new List<String>();
            //Set<Id> districtSet = new Set<Id>();
            for(District__c d : [SELECT Name, State__r.Name, State__r.Country__r.Name 
                                 FROM District__c 
                                 WHERE (Name LIKE :startingKeyword AND 
                                        State__r.Name LIKE :startingKeyword AND 
                                        State__r.Country__r.Name LIKE :startingKeyword)]) {
                                            listOfStateAndDistrict.add(d.Name);
                                            listOfStateAndDistrict.add(d.State__r.Name);
                                            listOfStateAndDistrict.add(d.State__r.Country__r.Name);
                                        }
            System.debug('Combination Of Country, States & District: '+listOfStateAndDistrict);    
        } catch (Exception e) {
            System.debug('No Such Country which starts with '+ startingKeyword);
        }
        
        // 2.Find the List of Districts whose length is greater than 
        // or equals to Any specified Number
        List<String> listOfDistrict = new List<String>();
        for(District__c d : [SELECT Name FROM District__c]) {
            if(d.Name.Length()>=12){
                listOfDistrict.add(d.Name);
            }
        }
        System.debug('Districts whose length greater than any no.: '+listOfDistrict);
        
		//Filling out the map dynamically
        for(District__c dist : listDistrict) {
            if(!mapCountryAndStateWithDistricts.containsKey(dist.State__r.Country__r.Name)){
                mapCountryAndStateWithDistricts.put(dist.State__r.Country__r.Name, 
                                                    new Map<String,List<String>>());
            }
            Map<String,List<String>> stateMap = 
                mapCountryAndStateWithDistricts.get(dist.State__r.Country__r.Name);
            if(!stateMap.containsKey(dist.State__r.Name)){
                stateMap.put(dist.State__r.Name, new List<String>());
            }
            stateMap.get(dist.State__r.Name).add(dist.Name);   
        }
        // 3. We can also Find the List of Districts whose length is greater 
        // than or equals to Any specified Number using map
        /*
        for(String gotCountry : mapCountryAndStateWithDistricts.keySet()) {
            if(mapCountryAndStateWithDistricts.containsKey(gotCountry)) {
                for(String gotState : mapCountryAndStateWithDistricts.get(gotCountry).keySet()) {
                    if(mapCountryAndStateWithDistricts.get(gotCountry).containsKey(gotState)){
                        for(String gotDistrict : 
                            mapCountryAndStateWithDistricts.get(gotCountry).get(gotState)) {
                                if(gotDistrict.length() >=12) {
                                    System.debug('District : '+gotDistrict);
                                } 
                            }
                    } 
                } 
            }
        }
		*/
        System.debug(mapCountryAndStateWithDistricts.get('India'));
        System.debug(mapCountryAndStateWithDistricts.get('United States'));
        System.debug(mapCountryAndStateWithDistricts.get('Germany'));
        System.debug(mapCountryAndStateWithDistricts.get('Switzerland'));   
    }
    
    // Method for the JSON Generator
    public void countryJSONGenerator(String countryName) {
        Country wrapCountry = new country();
        wrapCountry.countryName = countryName;
        States wrapState = new States();
        wrapCountry.states = new List<States>();
        if(mapCountryAndStateWithDistricts.containsKey(countryName)) {
            List<AggregateResult> listAggState = [SELECT COUNT(Name)Total_Number_Of_States 
                                                  FROM State__c 
                                                  WHERE Country__r.Name LIKE :countryName 
                                                  GROUP BY Country__r.Name];  
            wrapCountry.Total_Number_Of_States =  
                (Integer)listAggState[0].get('Total_Number_Of_States');
            List<AggregateResult> listAggDistrict = [SELECT COUNT(Name)Total_Number_Of_Districts 
                                                     FROM District__c
                                                     WHERE State__r.Country__r.Name LIKE :countryName 
                                                     GROUP BY State__r.Country__r.Name];    
            wrapCountry.Total_Number_Of_Districts = 
                (Integer)listAggDistrict[0].get('Total_Number_Of_Districts');
            for(String stateName :mapCountryAndStateWithDistricts.get(countryName).keySet()){
                wrapState.stateName = stateName;
                wrapState.districts = new list<Districts>();
                List<AggregateResult> listAggDistrictWithState = 
                    [SELECT COUNT(Name)Total_Number_Of_Districts 
                     FROM District__c
                     WHERE State__r.Country__r.Name LIKE :countryName 
                     GROUP BY State__r.Name]; 
                wrapState.Total_Number_Of_Districts = 
                    (Integer)listAggDistrictWithState[0].get('Total_Number_Of_Districts');
                if(mapCountryAndStateWithDistricts.get(countryName).containsKey(stateName)){
                    for(String districtName :
                        mapCountryAndStateWithDistricts.get(countryName).get(stateName)) {
                            Districts wrapDistrict = new Districts();
                            wrapDistrict.districtName = districtName;
                            WrapState.districts.add(wrapDistrict);
                        } 
                }
                wrapCountry.states.add(WrapState);
            }
        }
        else {
            throw new CountryNotFoundException();
        } 
        //} catch(CountryNotFoundException e) {
        //   System.debug('No such Country found');
        //}
        // Country__c.Country_JSON_Data__c abc = deserialize(jsonString, Country.class);
        //Country abc = (Country)JSON.deserialize(jsonString, Country.class);
        //System.debug(abc);
        String jsonString = JSON.serialize(wrapCountry);
        List<Country__c> listCont = [SELECT Id, Name, Country_Json_Data__c,
                                     Total_Number_of_Districts__c, 
                                     Total_Number_of_States__c 
                                     FROM Country__c WHERE Name LIKE :countryName];
        List<State__c> listState = [SELECT Id, Total_Number_of_Districts__c FROM State__c 
                                    WHERE Country__r.Name LIKE :countryName];
        if(!listCont.isEmpty()) {
            listCont[0].Country_Json_Data__c = jsonString;
            listCont[0].Total_Number_of_States__c = wrapCountry.Total_Number_Of_States;
            listCont[0].Total_Number_of_Districts__c = wrapCountry.Total_Number_Of_Districts;
            if(!listState.isEmpty()) {
                for(State__c state : listState) {
                    state.Total_Number_of_Districts__c = wrapState.Total_Number_Of_Districts;
                }
            }
            update listState;
            update listCont;
            System.debug(jsonString);   
            String linkOfRecord = URL.getSalesforceBaseUrl().toExternalForm()+'/'+listCont[0];
            System.debug(linkOfRecord);
        }   
    }
}
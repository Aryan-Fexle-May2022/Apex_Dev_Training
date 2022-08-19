/**
    Description     :   State Trigger Helper Class for State_Trigger.
                        Updating total_district, total_states and Json Data on Country
                        when inserting, updating or deleting State.
                        Filling map for JSON.
    Created BY      :   Aryan Sharma
    Created Date    :   08-08-2022
    Revision Logs   :   V_1.0 - Created
**/
public class StateTriggerHelper {
    public static Map<String, Map<String, List<String>>> mapCountryAndStateWithDistricts = 
        new Map<String, Map<String, List<String>>>(); 
    //These are the Wrapper Class for JSON
    public class Country{
        public String countryName{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
        public Integer Total_Number_Of_States{get; set;}
        public List<States> states{get; set;} 
    }
    public class States{
        public List<Districts> districts{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
        public String stateName{get; set;}
    }
    public class Districts {
        public String districtName{get; set;}
    }
    public static List<Country__c> countryListStateCountAndJSONToUpdate = new List<Country__c>();
    // Polulating  Country Records when Trigger is on State Object
    public static void populateCountryRecords(List<State__c> newStateList, Map<Id, State__c> oldStateMap) {
        Set<Id> countryIdSet = new Set<Id>();
        for(State__c State: (newStateList != null ? newStateList : oldStateMap.values())){
            if((oldStateMap != null && newStateList == null) || (newStateList != null && oldStateMap == null)) {
                countryIdSet.add(State.Country__c);
            }
            else if(oldStateMap.get(State.Id).Country__c != State.Country__c 
                    || oldStateMap.get(State.Id).State_Json_Data__c != State.State_Json_Data__c) 
            {
                countryIdSet.add(State.Country__c);
                countryIdSet.add(oldStateMap.get(State.Id).Country__c);
            }
        }
        if(!countryIdSet.isEmpty()){
            List<District__c> districtList = [SELECT Id, Name, State__c, State__r.Name, State__r.Country__c, 
                                              State__r.Country__r.Name FROM District__c 
                                              Where State__r.Country__c In : countryIdSet];
            //Filling out the map dynamically
            for(District__c dist : districtList) {
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
            // Count total States on Country
            List<AggregateResult> AggregateOfStateForCountry = [SELECT COUNT(Name)Total_Number_Of_States, 
                                                                SUM(Total_Number_of_Districts__c)Total_Number_Of_districts,
                                                                Country__c countryId,
                                                                Country__r.Name countryName FROM State__c 
                                                                WHERE Country__c In :countryIdSet 
                                                                GROUP BY Country__c, Country__r.Name];
            List<String> countryNameList = new List<String>();
            for(AggregateResult aggregate : AggregateOfStateForCountry) {
                countryNameList.add((String)aggregate.get('countryName'));
            }
            // JSON for Country
            for(String countryName : countryNameList) {
                Country wrapCountry = new country();
                States wrapState;
                Country__c country;
                for(AggregateResult aggregate : AggregateOfStateForCountry) {
                    if(countryName == (String)aggregate.get('countryName')) {
                        country = new Country__c();
                        country.Id = (Id)aggregate.get('countryId');
                        country.Total_Number_of_Districts__c = Integer.valueOf(aggregate.get('Total_Number_Of_districts')); 
                        wrapCountry.Total_Number_Of_States = (Integer)aggregate.get('Total_Number_Of_States');
                        wrapCountry.Total_Number_Of_Districts = Integer.valueOf(aggregate.get('Total_Number_Of_districts')); 
                        country.Total_Number_of_States__c = (Integer)aggregate.get('Total_Number_Of_States');
                    }
                }
                wrapCountry.countryName = countryName;
                wrapCountry.states = new List<States>();
                if(mapCountryAndStateWithDistricts.containsKey(countryName)) {
                    Set<String> statenameSet = mapCountryAndStateWithDistricts.get(countryName).keySet();
                    Integer countdist = 0;
                    for(String stateName : statenameSet){
                        wrapState = new States();
                        wrapState.stateName = stateName; 
                        wrapState.districts = new list<Districts>();
                        if(mapCountryAndStateWithDistricts.get(countryName).containsKey(stateName)){
                            List<String> distList = mapCountryAndStateWithDistricts.get(countryName).get(stateName);
                            wrapState.Total_Number_Of_Districts = distList.size();
                            for(String districtName : distList) {
                                Districts wrapDistrict = new Districts();
                                wrapDistrict.districtName = districtName;
                                WrapState.districts.add(wrapDistrict);
                            } 
                        }
                        wrapCountry.states.add(wrapState);
                    }
                    String jsonCountryData = JSON.serialize(wrapCountry);
                    country.Country_Json_Data__c = jsonCountryData;
                    countryListStateCountAndJSONToUpdate.add(country);
                }
            }
            if(!countryListStateCountAndJSONToUpdate.isEmpty()) {
                update countryListStateCountAndJSONToUpdate;
            } 
        } 
    }
}
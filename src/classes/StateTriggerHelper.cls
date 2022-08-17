/**
	Description 	:   State Trigger Helper Class for State_Trigger.
						Updating total_district, total_states and Json Data on Country
						when inserting, updating or deleting State.
						Filling map for JSON.
	Created BY 		:   Aryan Sharma
	Created Date 	:  	08-08-2022
	Revision Logs 	: 	V_1.0 - Created
**/
public class StateTriggerHelper {
    public static Map<String, Map<String, List<String>>> mapCountryAndStateWithDistricts = 
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
    public static List<Country__c> countryListDistrictCountToUpdate = new List<Country__c>();
    public static List<Country__c> countryListStateCountAndJSONToUpdate = new List<Country__c>();
    // Polulating  Country Records when Trigger is on State Object
    public static void populateCountryRecords(List<State__c> newStateList, List<State__c> oldStateList) {
        Set<Id> countryId = new Set<Id>();
        Set<Id> newCountryId = new Set<Id>();
        Set<Id> oldCountryId = new Set<Id>();
        // When District Records Deleted
        if(oldStateList != null && newStateList == null){
            for(State__c oldState : oldStateList) {
                countryId.add(oldState.Country__c);
            } 
        }
        else if(newStateList != null){
            // When new State Inserted
            if(newStateList != null && oldStateList == null) {
                for(State__c newState : newStateList) {
                    countryId.add(newState.Country__c);
                }
            }  
            //When Look Up of State changes from one Country to another
            // then Update Latest & Previous country 
            else {
                Integer count = 0;
                for(State__c newState : newStateList) {
                    if(newState.Country__c != null && 
                       (oldStateList[count] == null || oldStateList[count].Country__c != newState.Country__c )) {
                           newCountryId.add(newState.Country__c);
                           oldCountryId.add(oldStateList[count].Country__c);
                       } 
                    count = count + 1;
                } 
                countryId.addAll(newCountryId);
                countryId.addAll(oldCountryId);
            }
        }
        System.debug(countryId+'<---countryId');
        if(!countryId.isEmpty()){
            List<District__c> districtList = [SELECT Id, Name, State__c, State__r.Name, State__r.Country__c, 
                                              State__r.Country__r.Name FROM District__c Where State__r.Country__c In : countryId];
            System.debug(districtList);
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
            System.debug(mapCountryAndStateWithDistricts+'<--mapCountryAndStateWithDistricts');
            System.debug(mapCountryAndStateWithDistricts.get('India'));
            System.debug(mapCountryAndStateWithDistricts.get('Country 1'));
            // Count total Districts on Country
            List<AggregateResult> AggregateOfDistrictforCountry = [Select COUNT(Name)Total_Number_Of_districts,
                                                                   State__r.Country__c countryId,
                                                                   State__r.Country__r.Name countryName From District__c
                                                                   Where State__r.Country__c In :countryId 
                                                                   Group By State__r.Country__c, State__r.Country__r.Name];
            System.debug(AggregateOfDistrictforCountry+'<---AggregateOfDistrictforCountry');
            List<String> conName = new List<String>();
            for(AggregateResult aggregate : AggregateOfDistrictforCountry) {
                conName.add((String)aggregate.get('countryName'));
            }
            // Count total States on Country
            List<AggregateResult> AggregateOfStateForCountry = [SELECT COUNT(Name)Total_Number_Of_States, Country__c countryId,
                                                                Country__r.Name countryName FROM State__c 
                                                                WHERE Country__c In :countryId 
                                                                GROUP BY Country__c, Country__r.Name];
            System.debug(AggregateOfStateForCountry+'<---AggregateOfStateForCountry');
            System.debug(conName+'<---conName');
            // JSON for Country
            for(String countryName : conName) {
                Country wrapCountry = new country();
                States wrapState;
                Country__c country;
                for(AggregateResult aggregate : AggregateOfStateForCountry) {
                    if(countryName == (String)aggregate.get('countryName')) {
                        country = new Country__c();
                        country.Id = (Id)aggregate.get('countryId');
                        wrapCountry.Total_Number_Of_States = (Integer)aggregate.get('Total_Number_Of_States');
                        country.Total_Number_of_States__c = (Integer)aggregate.get('Total_Number_Of_States');
                    }
                }
                Country__c ct;
                for(AggregateResult aggregate : AggregateOfDistrictforCountry) {
                    if(countryName == (String)aggregate.get('countryName')) {
                        wrapCountry.Total_Number_Of_Districts = (Integer)aggregate.get('Total_Number_Of_Districts');
                        ct = new Country__c();
                        ct.Id = (Id)aggregate.get('countryId');
                        ct.Total_Number_of_Districts__c = (Integer)aggregate.get('Total_Number_Of_districts'); 
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
                    ct.Country_Json_Data__c = jsonCountryData;
                    countryListDistrictCountToUpdate.add(country);
                    countryListStateCountAndJSONToUpdate.add(ct);
                }
            }
            System.debug(countryListDistrictCountToUpdate+'<---countryListDistrictCountToUpdate');
            System.debug(countryListStateCountAndJSONToUpdate+'<---countryListStateCountAndJSONToUpdate');
            if(!countryListDistrictCountToUpdate.isEmpty()) {
                update countryListDistrictCountToUpdate;
            }
            if(!countryListStateCountAndJSONToUpdate.isEmpty()) {
                update countryListStateCountAndJSONToUpdate;
            }  
        } 
    }
}
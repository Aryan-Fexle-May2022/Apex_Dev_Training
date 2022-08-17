/**
	Description 	:   District Trigger Helper Class for District_Trigger.
						Updating total_states, total_district and Json Data on State and Country
						when inserting, updating or deleting District.
						Filling Map for JSON. 
	Created BY 		:   Aryan Sharma
	Created Date 	:  	08-08-2022
	Revision Logs 	: 	V_1.0 - Created
**/
public class DistrictTriggerHelper {
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
    public static List<State__c> stateListToUpdate = new List<State__c>();
    public static List<Country__c> countryListToUpdate = new List<Country__c>();
    // Polulating State Country Records when Trigger is on District Object
    public static void populateCountryStateRecords(List<District__c> newDistList, List<District__c> oldDistList) {
        Set<Id> stateId = new Set<Id>();
        Set<Id> countryId = new Set<Id>();
        Set<Id> newStateId = new Set<Id>();
        Set<Id> oldStateId = new Set<Id>();
        // When District Records Deleted
        if(oldDistList != null && newDistList == null){
            for(District__c oldDist : oldDistList) {
                stateId.add(oldDist.State__c);
                System.debug(stateId+'<---stateId');
            } 
        }
        else if(newDistList != null){
            // When new District Inserted
            if(newDistList != null && oldDistList == null) {
                for(District__c newDist : newDistList) {
                    stateId.add(newDist.State__c);
                    System.debug(stateId+'<---stateId');
                }
            }  
            //When Look Up of District changes from one state to another
            // then Update Latest & Previous state and country 
            else {
                Integer count=0;
                for(District__c newDist : newDistList) {
                    if((newDist.State__c != null) && 
                       (oldDistList == null || oldDistList[count].State__c != newDist.State__c)) {
                           newStateId.add(newDist.State__c);
                           System.debug(newStateId+'<---newStateId');
                           oldStateId.add(oldDistList[count].State__c);
                           System.debug(oldStateId+'<---oldStateId');
                       }
                    count = count+1; 
                } 
            } 
            stateId.addAll(newStateId);
            stateId.addAll(oldStateId);
        }
        System.debug(stateId+'<---stateId');
        List<State__c> stSet = [Select Id, Name, Country__c From State__c Where Id In :stateId];
        System.debug(stSet+'<---stSet');
        for(State__c st : stSet){
            countryId.add(st.Country__c);
        }
        if(!countryId.isEmpty()){
            System.debug(countryId+'<---countryId');
            List<District__c> districtList = [SELECT Id, Name, State__c, State__r.Name, State__r.Country__c, 
                                              State__r.Country__r.Name FROM District__c Where State__r.Country__c In :countryId];
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
            System.debug(countryId+'<---countryId');
            // Count total Districts on State
            List<AggregateResult> AggregateOfDistrictforState = [Select COUNT(Name)Total_Number_Of_districts, State__c stateId, 
                                                                 State__r.Name stateName, State__r.Country__r.Name countryName
                                                                 From District__c
                                                                 Where State__c In :stateId 
                                                                 Group By State__c, State__r.Name,  State__r.Country__r.Name];
            Set<String>  conName = new Set<String>();
            for(AggregateResult aggregate : AggregateOfDistrictforState) {
                conName.add((String)aggregate.get('countryName'));
            }
            System.debug(AggregateOfDistrictforState+'<---AggregateOfDistrictforState');
            // Count total districts on Country
            List<AggregateResult> AggregateOfDistrictforCountry = [Select COUNT(Name)Total_Number_Of_districts,
                                                                   State__r.Country__c countryId,
                                                                   State__r.Country__r.Name countryName From District__c
                                                                   Where State__r.Country__c In :countryId 
                                                                   Group By State__r.Country__c, State__r.Country__r.Name];
            System.debug(AggregateOfDistrictforCountry+'<---AggregateOfDistrictforCountry');
            // Count total states on Country
            List<AggregateResult> AggregateOfStateforCountry = [SELECT COUNT(Name)Total_Number_Of_States 
                                                                FROM State__c 
                                                                WHERE Country__c In :countryId 
                                                                GROUP BY Country__r.Name];
            System.debug(AggregateOfStateforCountry+'<---AggregateOfStateforCountry');
            // JSON for state
            for(String countryName : conName){
                States wrapState;
                for(AggregateResult stateName : AggregateOfDistrictforState) {
                    wrapState = new States();
                    wrapState.stateName = (String)stateName.get('stateName'); 
                    wrapState.districts = new list<Districts>();
                    wrapState.Total_Number_Of_Districts = (Integer)stateName.get('Total_Number_Of_Districts');
                    System.debug((String)stateName.get('stateName')+'<---stateName');
                    System.debug(countryName+'<--countryName');
                    if(mapCountryAndStateWithDistricts.get(countryName).containsKey((String)stateName.get('stateName'))){
                        for(String districtName : mapCountryAndStateWithDistricts.get(countryName).get((String)stateName.get('stateName'))) 
                        {
                            Districts wrapDistrict = new Districts();
                            wrapDistrict.districtName = districtName;
                            WrapState.districts.add(wrapDistrict);
                        } 
                    }
                    String jsonStateData = JSON.serialize(WrapState);
                    State__c st = new State__c();
                    st.Id = (Id)stateName.get('stateId');
                    st.State_Json_Data__c = jsonStateData;
                    st.Total_Number_of_Districts__c = (Integer)stateName.get('Total_Number_Of_districts');
                    stateListToUpdate.add(st);
                } 
            }
            // JSON for Country
            for(String countryName : conName) {
                Country wrapCountry = new country();
                States wrapState;
                for(AggregateResult aggregate : AggregateOfStateforCountry) {
                    wrapCountry.Total_Number_Of_States = (Integer)aggregate.get('Total_Number_Of_States');
                }
                Country__c ct;
                for(AggregateResult aggregate : AggregateOfDistrictforCountry) {
                    if(countryName == (String)aggregate.get('countryName')){
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
                    countryListToUpdate.add(ct);
                }
            }
            System.debug(stateListToUpdate+'<---stateListToUpdate');
            System.debug(countryListToUpdate+'<---countryListToUpdate');
            Map<Id, State__c> mapState = new Map<Id, State__c>();
            if(stateListToUpdate.size() >0) {
                mapState.putAll(stateListToUpdate);
            }
            if(mapState.size() >0) {
                update mapState.values();
            }
            if(countryListToUpdate.size() >0) {
                update countryListToUpdate;
            }
        }
    }
}
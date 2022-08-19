/**
    Description     :   District Trigger Helper Class for District_Trigger.
                        Updating total_states, total_district and Json Data on State and Country
                        when inserting, updating or deleting District.
                        Filling Map for JSON. 
    Created BY      :   Aryan Sharma
    Created Date    :   08-08-2022
    Revision Logs   :   V_1.0 - Created
**/
public class DistrictTriggerHelper {
    public static Map<String,List<String>> mapStateWithDistricts = new Map<String,List<String>>(); 
    //These are the Wrapper Class for JSON
    public class States{
        public List<Districts> districts{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
        public String stateName{get; set;}
    }
    public class Districts {
        public String districtName{get; set;}
    }
    public static List<State__c> stateListToUpdate = new List<State__c>();
    // Polulating State Country Records when Trigger is on District Object
    public static void populateCountryStateRecords(List<District__c> newDistList, Map<Id, District__c> oldDistMap) {
        Set<Id> stateId = new Set<Id>();
        for(District__c district: (newDistList != null ? newDistList : oldDistMap.values())){
            if(oldDistMap != null && newDistList == null){
                stateId.add(district.State__c);
                System.debug(stateId+'<---stateId');
            }
            else if(newDistList != null && oldDistMap == null) {
                stateId.add(district.State__c);
                System.debug(stateId+'<---stateId');
            }
            else if(newDistList != null && oldDistMap.get(district.Id).State__c != district.State__c) 
            {
                stateId.add(district.State__c);
                System.debug(stateId+'<---stateId');
                stateId.add(oldDistMap.get(district.Id).State__c);
                System.debug(stateId+'<---stateId');
            }
        }
        System.debug(stateId+'<---stateId');
        if(!stateId.isEmpty()){
            List<District__c> districtList = [SELECT Id, Name, State__c, State__r.Name, State__r.Country__c, 
                                              State__r.Country__r.Name FROM District__c WHERE State__c In :stateId];
            System.debug(districtList);
            //Filling out the map dynamically
            for(District__c dist : districtList) {
                if(!mapStateWithDistricts.containsKey(dist.State__r.Name)){
                    mapStateWithDistricts.put(dist.State__r.Name, new List<String>());
                }  
                mapStateWithDistricts.get(dist.State__r.Name).add(dist.Name);   
            }
            System.debug(mapStateWithDistricts+'<--mapStateWithDistricts');
            System.debug(mapStateWithDistricts.get('Rajasthan'));
            System.debug(mapStateWithDistricts.get('State 1'));
            // Count total Districts on State
            List<AggregateResult> AggregateOfDistrictforState = [SELECT COUNT(Name)Total_Number_Of_districts, 
                                                                 State__c stateId, State__r.Name stateName 
                                                                 FROM District__c WHERE State__c In :stateId 
                                                                 GROUP BY State__c, State__r.Name];
            System.debug(AggregateOfDistrictforState+'<---AggregateOfDistrictforState');            
            for(AggregateResult stateName : AggregateOfDistrictforState) {
                States wrapState = new States();
                wrapState.stateName = (String)stateName.get('stateName'); 
                wrapState.districts = new list<Districts>();
                wrapState.Total_Number_Of_Districts = (Integer)stateName.get('Total_Number_Of_Districts');
                System.debug((String)stateName.get('stateName')+'<---stateName');
                if(mapStateWithDistricts.containsKey((String)stateName.get('stateName'))){
                    for(String districtName : mapStateWithDistricts.get((String)stateName.get('stateName'))) 
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
            System.debug(stateListToUpdate+'<---stateListToUpdate');
            Map<Id, State__c> mapState = new Map<Id, State__c>();
            if(!stateListToUpdate.isEmpty()) {
                mapState.putAll(stateListToUpdate);
            }
            if(!mapState.isEmpty()) {
                update mapState.values();
            }
        }
    }
}
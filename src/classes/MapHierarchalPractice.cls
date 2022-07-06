/*
CountryCode 
    -country
        -state
            -district
*/
public with sharing class MapHierarchalPractice {
    
    
    public MapHierarchalPractice() {
        Map<Integer, Map<String, Map<String, List<String>>>> mapOfMapOfMapOfList = new 
            Map<Integer, Map<String, Map<String, List<String>>>>();
        
        
        //List of state with country 
        List<String> stateListOfIndia = new List<String>{'Rajasthan','Maharashtra','Delhi','Gujarat'};
        List<String> stateListOfUS = new List<String>{'Arizona','Florida'};
        List<String> stateListOfAustralia= new List<String>{'Queensland','South Australia',
        'Victoria', 'Central Queensland'};
        List<String> stateListOfCalifornia = new List<String>{'Alberta','British Columbia','Bavaria', 
        'Saxnony'};
        List<String> stateListOfSwitzerland = new List<String>{'Fribourg','Jura ','Solothurn', 'Zug'};

        //List of district with state of India
        List<String> distListOfRajasthan = new List<String>{'Jhunujhunu','Sikar','Ajmer','Bikaner'};
        List<String> distListOfMaharashtra = new List<String>{'Solapur','Nashik'};
        List<String> distListOfDelhi = new List<String>{'New Delhi','Central Delhi'};
        List<String> distListOfGujarat = new List<String>{'Ahmedabad','Rajkot','Bharuch', 'Gandhinagar'};
        

        //List of district with state of US
        List<String> distListOfArizona = new List<String>{'Mesa','Phoenix'};
        List<String> distListOfFlorida = new List<String>{'Miami', 'Searland'};
                
        //List of district with state of Australia
        List<String> distListOfQueensland = new List<String>{'Brisbane','Airdrie'};
        List<String> distListOfSouthAustralia = new List<String>{'Hunter','South Coast','Mid North'};
        List<String> distListOfVictoria  = new List<String>{'Altona','Bass','Bayswater', 'Benambra'};
        List<String> distListOfCentralQueensland = new List<String>{'South Esk','Noth Esk','Lennox',
        'Amher'};

        //List of district with state of California 
        List<String> distListOfAlberta = new List<String>{'Airdrie','SikCamrosear'};
        List<String> distListOfBritishColumbia = new List<String>{'Britz','Buch','Gatow','Karow'};
        List<String> distListOfBavaria = new List<String>{'Munoch','Furth'};
        List<String> distListOfSaxnony = new List<String>{'Hamburg','Saxony-Anhalt','Thuringia'};
                                                                                
        //List of district with state of Solothurn
        List<String> distListOfSolothurn = new List<String>{'Steckenberg','Unter Wiler',
        'Rodersdorf', 'Oberdorf'};
        List<String> distListOfZug = new List<String>{'Gottschalkenberg','','Morgarten','Neuaegeri'};
        List<String> distListOfJura = new List<String>{'Asuel', 'Bassecourt','Berlincourt','Beurnevesin'};
        List<String> distListOfFribourg = new List<String>{'Avry','devant-Pont','Bethanie','Buechslen'};
                                                                                
        // map of district with state
        Map<String, List<String>> mapOfDistrictWithStateIndia = 
        new Map<String, List<String>>{'Rajasthan' => distListOfRajasthan,
            'Maharashtra' => distListOfMaharashtra,'Delhi' => distListOfDelhi,
            'Gujarat' => distListOfGujarat};
                
        Map<String, List<String>> mapOfDistrictWithStateUS = 
        new Map<String, List<String>>{'Arizona' => distListOfArizona,
            'Florida' => distListOfFlorida };
                        
        Map<String, List<String>> mapOfDistrictWithStateAustralia = new Map<String, List<String>>{
            'Queensland' => distListOfQueensland,'South Australia' => distListOfSouthAustralia,
            'Victoria' => distListOfVictoria,
            'Central Queensland' => distListOfCentralQueensland};
                                    
        Map<String, List<String>> mapOfDistrictWithStateCalifornia = new Map<String, List<String>>{
            'British Columbia' => distListOfBritishColumbia,'Bavaria' => distListOfBavaria,
            'Saxnony'=> distListOfSaxnony,'Alberta'=> distListOfAlberta};

        Map<String, List<String>> mapOfDistrictWithStateSwitzerland = new Map<String, List<String>>{
            'Solothurn' => distListOfSolothurn,'Zug' => distListOfZug,
            'Jura'=> distListOfJura,'Fribourg'=> distListOfFribourg};
    
        // MapOfStateWithCountry---used for mapofCountryWithCountryCode
        Map<String, Map<String, List<String>>> mapOfStateWithCountryIndia = 
        new  Map<String, Map<String, List<String>>>();
        mapOfStateWithCountryIndia.put('India',mapOfDistrictWithStateIndia);
        
        Map<String, Map<String, List<String>>> mapOfStateWithCountryUS = 
        new  Map<String, Map<String, List<String>>>();
        mapOfStateWithCountryUS.put('US',mapOfDistrictWithStateUS);
        
        Map<String, Map<String, List<String>>> mapOfStateWithCountryAustralia = new 
        Map<String, Map<String, List<String>>>();
        mapOfStateWithCountryAustralia.put('Australia',mapOfDistrictWithStateAustralia);
        
        Map<String, Map<String, List<String>>> mapOfStateWithCountryCalifornia = new  
        Map<String, Map<String, List<String>>>();
        mapOfStateWithCountryCalifornia.put('California',mapOfDistrictWithStateCalifornia);

        Map<String, Map<String, List<String>>> mapOfStateWithCountrySwitzerland = 
        new  Map<String, Map<String, List<String>>>();
        mapOfStateWithCountryCalifornia.put('Switzerland',mapOfDistrictWithStateSwitzerland);

        // This is also mapOfStateWithCountry
        Map<String, Map<String, List<String>>> mapOfStateWithCountry = 
        new Map<String, Map<String, List<String>>>();
        mapOfStateWithCountry.put('India',mapOfDistrictWithStateIndia);
        mapOfStateWithCountry.put('US',mapOfDistrictWithStateUS);
        mapOfStateWithCountry.put('Australia',mapOfDistrictWithStateAustralia);
        mapOfStateWithCountry.put('California',mapOfDistrictWithStateCalifornia);
        mapOfStateWithCountry.put('Switzerland',mapOfDistrictWithStateSwitzerland);

        //map of countryName with countryCode
        mapOfMapOfMapOfList.put(91,mapOfStateWithCountryIndia);
        mapOfMapOfMapOfList.put(1,mapOfStateWithCountryUS);
        mapOfMapOfMapOfList.put(61,mapOfStateWithCountryAustralia);
        mapOfMapOfMapOfList.put(13,mapOfStateWithCountryCalifornia);
        mapOfMapOfMapOfList.put(41,mapOfStateWithCountrySwitzerland);
        
        
        // All the Country Names along with - State & associated Districts using Country Code
        System.debug('Country Code : 91 : ' +mapOfMapOfMapOfList.get(91));
        System.debug('Country Code : 1 : ' +mapOfMapOfMapOfList.get(91));
        System.debug('Country Code : 61 : ' +mapOfMapOfMapOfList.get(91));
        System.debug('Country Code : 13 : ' +mapOfMapOfMapOfList.get(91));
        System.debug('Country Code : 41 : ' +mapOfMapOfMapOfList.get(41));

        //System.debug(mapOfStateWithCountry.get('India').get('Rajasthan'));


        // 1. Combination of Country, state and districts where it starts with 's'.
        System.debug('Comibinations of Countries, States and Districts which starts with s : ');
        for(String gotCountry : mapOfStateWithCountry.keySet()) {
            if(gotCountry.startsWithIgnoreCase('S')) {
                System.debug('Country : '+gotCountry);
                for(String gotState : mapOfStateWithCountry.get(gotCountry).keySet()) {
                    if(gotState.startsWIthIgnoreCase('S')) {
                        System.debug('State : '+gotState);
                        for(String gotDistrict : mapOfStateWithCountry.get(gotCountry).get(gotState)) {
                            if(gotDistrict.startsWIthIgnoreCase('S')) {
                                System.debug('District : '+gotDistrict);
                            }
                        }
                    }  
                }
            }
        }


        // 2. Find such a District which length is more or equal to some number.
        System.debug('District which length is more or equal to 12 : ');
        for(String gotCountry : mapOfStateWithCountry.keySet()) {
            for(String gotState : mapOfStateWithCountry.get(gotCountry).keySet()) {
                for(String gotDistrict : mapOfStateWithCountry.get(gotCountry).get(gotState)) {
                    if(gotDistrict.length() >=12) {
                        System.debug('District : '+gotDistrict);
                    }
                }
            }
        }
    }
}

/**
	Description :   Helper Class For Opportunity_Trigger
	Created BY :    Aryan Sharma
	Created Date :  29-07-2022
	Revision Logs : V_1.0 - Created 								  
**/
public class OpportunityTriggerHelper {
    // List of Automobile Sensor's to be inserted
    public static List<Automobile_Sensor__c> sensorListtoInsert = new List<Automobile_Sensor__c>();
    public static List<Automobile_Presence_Sensor__c> presenceSensorListtoInsert = 
        new List<Automobile_Presence_Sensor__c>();
    public static List<Automobile_TDU__c> tduListtoInsert = new List<Automobile_TDU__c>();
    public static List<Automobile_Tag__c> tagListtoInsert = new List<Automobile_Tag__c>();
    
    // List of Automobile Sensor's to be updated
    public static List<Automobile_Sensor__c> sensorListtoUpdate = new List<Automobile_Sensor__c>();
    public static List<Automobile_Presence_Sensor__c> presenceSensorListtoUpdate = 
        new List<Automobile_Presence_Sensor__c>();
    public static List<Automobile_TDU__c> tduListtoUpdate = new List<Automobile_TDU__c>();
    public static List<Automobile_Tag__c> tagListtoUpdate = new List<Automobile_Tag__c>();
    //List of sObjects for insertion and updation
    public static List<sObject> listsObjectsToInsert = new List<sObject>();
    public static List<sObject> listsObjectsToUpdate = new List<sObject>();
    //Sensor Name List
    public static List<String> sensorNameList = new List<String>();
    //Map of Opportunity with the Sensors
    public static Map<Id, Set<String>> mapOfOppwithSensors = new Map<Id, Set<String>>();
    //Map of Opportunity with Ids
    public static Map<Id, Opportunity> mapOfOppwithId = new Map<Id, Opportunity>();
    // Populating Automobile Sensor Records
    public static void populateAutomobileSensorRecords(List<Opportunity> newOppList, Map<Id, Opportunity> oldOppMap) {
        // Existing Automobile Sensors Set when insert
        Set<String> existingAutomobileSensorSet = new Set<String>();
        Set<String> existingAutomobilePresenceSensorSet = new Set<String>();
        Set<String> existingAutomobileTDUSensorSet = new Set<String>();
        Set<String> existingAutomobileTagSensorSet = new Set<String>();
        
        // Existing Automobile map used when update
        Map<Id, Automobile_Sensor__c> mapOfOppwithAutomobileSensor = new Map<Id, Automobile_Sensor__c>();
        Map<Id, Automobile_Presence_Sensor__c> mapOfOppwithAutomobilePresenceSensor = new Map<Id, Automobile_Presence_Sensor__c>();
        Map<Id, Automobile_TDU__c> mapOfOppwithAutomobileTDUSensor = new Map<Id, Automobile_TDU__c>();
        Map<Id, Automobile_Tag__c> mapOfOppwithAutomobileTagSensor = new Map<Id, Automobile_Tag__c>(); 
        // Set of Sensor Set
        Set<String> sensorSet;
        for(Opportunity opp : newOppList){
            if(opp.StageName == 'Shipped to Customer' || opp.StageName == 'Return to HQ' || opp.StageName == 'Return to Customer')    
            {
                if((opp.Automobile_Tag_Details_1__c != null || opp.Automobile_Tag_Details_2__c != null ||
                    opp.Automobile_Tag_Details_3__c != null || opp.Return_To_HQ__c != null) && 
                   (oldOppMap == null || ((opp.Id == oldOppMap.get(opp.Id).Id) && 
                                          (opp.Automobile_Tag_Details_1__c != oldOppMap.get(opp.Id).Automobile_Tag_Details_1__c || 
                                           opp.Automobile_Tag_Details_2__c != oldOppMap.get(opp.Id).Automobile_Tag_Details_2__c || 
                                           opp.Automobile_Tag_Details_3__c != oldOppMap.get(opp.Id).Automobile_Tag_Details_3__c || 
                                           opp.Return_To_HQ__c != oldOppMap.get(opp.Id).Return_To_HQ__c || 
                                           opp.StageName != oldOppMap.get(opp.Id).StageName)))) 
                {
                    sensorSet = new Set<String>();
                    if(opp.StageName == 'Shipped to Customer' || opp.StageName == 'Return to Customer') {
                        if(opp.Automobile_Tag_Details_1__c != null){
                            List<String> detail1 = new List<String>(opp.Automobile_Tag_Details_1__c.split('\r\n'));
                            sensorSet.addAll(detail1);
                            System.debug(detail1+' <-- detail1');
                            System.debug(sensorSet+' <-- sensorSet');
                        }
                        if(opp.Automobile_Tag_Details_2__c != null){
                            List<String> detail2 = new List<String>(opp.Automobile_Tag_Details_2__c.split('\r\n'));
                            sensorSet.addAll(detail2);
                            System.debug(detail2+' <-- detail2');
                            System.debug(sensorSet+' <-- sensorSet');
                        }
                        
                        if(opp.Automobile_Tag_Details_3__c != null) {
                            List<String> detail3 = new List<String>(opp.Automobile_Tag_Details_3__c.split('\r\n'));
                            sensorSet.addAll(detail3);
                            System.debug(detail3+' <-- detail3');
                            System.debug(sensorSet+' <-- sensorSet');
                        }
                    }
                    else if(opp.StageName == 'Return to HQ'){
                        if(opp.Return_To_HQ__c != null) {
                            List<String> detail4 = new List<String>(opp.Return_To_HQ__c.split('\r\n'));
                            sensorSet.addAll(detail4);
                            System.debug(detail4+' <-- detail4');
                            System.debug(sensorSet+' <-- sensorSet');
                        }
                    }
                    if(sensorSet.size()>0) {
                        sensorNameList.addAll(sensorSet);
                        mapOfOppwithSensors.put(opp.Id, sensorSet); 
                    }
                    MapOfOppwithId.put(opp.Id, opp);  
                }
            }
            else {
                opp.StageName.addError('Stage Name should be anyone of them--> "Shipped to Customer", "Return to HQ", "Return to Customer"');
            }
        }
        System.debug(mapOfOppwithSensors+'mapOfOppwithSensors');
        System.debug(sensorNameList+'sensorList');        
        if(mapOfOppwithSensors.size() >0) {
            List<Automobile_Sensor__c> existingSensorList = [SELECT Id, Name, Opportunity__c, Account__c From Automobile_Sensor__c
                                                             WHERE Opportunity__c In : mapOfOppwithSensors.keySet() AND 
                                                             Name In : sensorNameList];
            System.debug(existingSensorList);
            List<Automobile_Presence_Sensor__c> existingPresenceList = [SELECT Id, Name, Opportunity__c, Account__c From 
                                                                        Automobile_Presence_Sensor__c
                                                                        WHERE Opportunity__c In : mapOfOppwithSensors.keySet() AND 
                                                                        Name In : sensorNameList];
            System.debug(existingPresenceList);
            List<Automobile_TDU__c> existingTduList = [SELECT Id, Name, Opportunity__c, Account__c From Automobile_TDU__c
                                                       WHERE Opportunity__c In : mapOfOppwithSensors.keySet() AND Name In :  sensorNameList];
            System.debug(existingTduList);
            List<Automobile_Tag__c> existingTagList = [SELECT Id, Name, Opportunity__c, Account__c From Automobile_Tag__c
                                                       WHERE Opportunity__c In : mapOfOppwithSensors.keySet() AND Name In : sensorNameList];
            System.debug(existingTagList);
            for(Automobile_Sensor__c auto_Sensor : existingSensorList) {
                mapOfOppwithAutomobileSensor.put(auto_Sensor.Opportunity__c, auto_Sensor);
                existingAutomobileSensorSet.add(auto_Sensor.Name);
            }
            for(Automobile_Presence_Sensor__c auto_Sensor : existingPresenceList) {
                mapOfOppwithAutomobilePresenceSensor.put(auto_Sensor.Opportunity__c, auto_Sensor);
                existingAutomobilePresenceSensorSet.add(auto_Sensor.Name);
            }
            for(Automobile_TDU__c auto_Sensor : existingTduList) {
                mapOfOppwithAutomobileTDUSensor.put(auto_Sensor.Opportunity__c, auto_Sensor);
                existingAutomobileTDUSensorSet.add(auto_Sensor.Name);
            }
            for(Automobile_Tag__c auto_Sensor : existingTagList) {
                mapOfOppwithAutomobileTagSensor.put(auto_Sensor.Opportunity__c, auto_Sensor);
                existingAutomobileTagSensorSet.add(auto_Sensor.Name);
            }
            // Creating the Opportunity and Related Automobile Records
            for(Opportunity newOpp : MapOfOppwithId.values())
            {
                if((oldOppMap == null) || ((newOpp.Id == oldOppMap.get(newOpp.Id).Id) && (
                    newOpp.Automobile_Tag_Details_1__c != oldOppMap.get(newOpp.Id).Automobile_Tag_Details_1__c || 
                    newOpp.Automobile_Tag_Details_2__c != oldOppMap.get(newOpp.Id).Automobile_Tag_Details_2__c || 
                    newOpp.Automobile_Tag_Details_3__c != oldOppMap.get(newOpp.Id).Automobile_Tag_Details_3__c )))
                {
                    Set<String> setName = mapOfOppwithSensors.get(newOpp.Id);
                    System.debug(setName+'<---Setname');
                    for(String str :  setName) {
                        String name = (str.length()>18) ? str.substring(0, 18) : str;
                        if(name.startsWith('00:11:CE:00')){
                            if(!existingAutomobileSensorSet.contains(name)){
                                Automobile_Sensor__c sensor = new Automobile_Sensor__c();
                                sensor.Name = name;
                                sensor.Opportunity__c = newOpp.Id;
                                if(newOpp.StageName == 'Shipped to Customer' || newOpp.StageName == 'Return to Customer' )
                                    sensor.Account__c = newOpp.AccountId;
                                else 
                                    sensor.Account__c = newOpp.Shipment_Account__c;
                                sensorListtoInsert.add(sensor);
                            }
                            else {
                                if(newOpp.StageName == 'Shipped to Customer' || newOpp.StageName == 'Return to Customer' ) {
                                    newOpp.addError('Duplicate Automobile Sensor found Under Installation Account - '+name);
                                }
                                else {
                                    newOpp.addError('Duplicate Automobile Sensor found Under Shipment Account - '+name);
                                }     
                            }
                        }
                        else if(name.startsWith('00:11:CE:D:')) {
                            if(!existingAutomobilePresenceSensorSet.contains(name)){
                                Automobile_Presence_Sensor__c presence_sensor = new Automobile_Presence_Sensor__c();
                                presence_sensor.Name = name;
                                presence_sensor.Opportunity__c = newOpp.Id;
                                if(newOpp.StageName == 'Shipped to Customer' || newOpp.StageName == 'Return to Customer' )
                                    presence_sensor.Account__c = newOpp.AccountId;
                                else 
                                    presence_sensor.Account__c = newOpp.Shipment_Account__c;
                                presenceSensorListtoInsert.add(presence_sensor);
                            }
                            else {
                                if(newOpp.StageName == 'Shipped to Customer' || newOpp.StageName == 'Return to Customer' ) {
                                    newOpp.addError('Duplicate Automobile Sensor found Under Installation Account - '+name);
                                }
                                else {
                                    newOpp.addError('Duplicate Automobile Sensor found Under Shipment Account - '+name);
                                }     
                            }
                        }  
                        else if(name.startsWith('00:11:CE:E:')){
                            if(!existingAutomobileTDUSensorSet.contains(name)){
                                Automobile_TDU__c tdu = new Automobile_TDU__c();
                                tdu.Name = name;
                                tdu.Opportunity__c = newOpp.Id;
                                if(newOpp.StageName == 'Shipped to Customer' || newOpp.StageName == 'Return to Customer' )
                                    tdu.Account__c = newOpp.AccountId;
                                else 
                                    tdu.Account__c = newOpp.Shipment_Account__c;
                                tduListtoInsert.add(tdu);
                            }
                            
                            else {
                                if(newOpp.StageName == 'Shipped to Customer' || newOpp.StageName == 'Return to Customer' ) {
                                    newOpp.addError('Duplicate Automobile Sensor found Under Installation Account - '+name);
                                }
                                else {
                                    newOpp.addError('Duplicate Automobile Sensor found Under Shipment Account - '+name);
                                }     
                            }
                        }
                        else if(name.substring(0,3).isNumeric()) {
                            if(!existingAutomobileTagSensorSet.contains(name)){
                                Automobile_Tag__c tag = new Automobile_Tag__c();
                                tag.Name = name;
                                tag.Opportunity__c = newOpp.Id;
                                if(newOpp.StageName == 'Shipped to Customer' || newOpp.StageName == 'Return to Customer' )
                                    tag.Account__c = newOpp.AccountId;
                                else 
                                    tag.Account__c = newOpp.Shipment_Account__c;
                                tagListtoInsert.add(tag);
                            }
                            else {
                                if(newOpp.StageName == 'Shipped to Customer' || newOpp.StageName == 'Return to Customer' ) {
                                    newOpp.addError('Duplicate Automobile Sensor found Under Installation Account - '+name);
                                }
                                else {
                                    newOpp.addError('Duplicate Automobile Sensor found Under Shipment Account - '+name);
                                }     
                            }
                        }
                    }
                }
                // Update Automobile Records 
                if(oldOppMap != null && newOpp.Id == oldOppMap.get(newOpp.Id).Id && newOpp.StageName != 
                   oldOppMap.get(newOpp.Id).StageName) 
                {
                    //Format of My sensor && Opportunity Stage
                    if(newOpp.StageName == 'Return to HQ') {
                        if(mapOfOppwithAutomobileSensor.size() >0) {
                            for(Automobile_Sensor__c sensor : mapOfOppwithAutomobileSensor.values()) {
                                Automobile_Sensor__c AutomobileSensorForUpdate = new 
                                    Automobile_Sensor__c(Id = sensor.Id, Account__c = newOpp.Shipment_Account__c,
                                                         Opportunity__c = newOpp.Id);
                                sensorListtoUpdate.add(AutomobileSensorForUpdate);
                            }
                        }
                        if(mapOfOppwithAutomobilePresenceSensor.size() >0) {
                            for(Automobile_Presence_Sensor__c sensor : mapOfOppwithAutomobilePresenceSensor.values()) {
                                Automobile_Presence_Sensor__c AutomobilePresenceSensorForUpdate = new 
                                    Automobile_Presence_Sensor__c(Id = sensor.Id, Account__c = newOpp.Shipment_Account__c,
                                                                  Opportunity__c = newOpp.Id);
                                presenceSensorListtoUpdate.add(AutomobilePresenceSensorForUpdate);
                            }
                        }
                        if(mapOfOppwithAutomobileTDUSensor.size() >0) {
                            for(Automobile_TDU__c sensor : mapOfOppwithAutomobileTDUSensor.values()) {
                                Automobile_TDU__c AutomobileTDUSensorForUpdate = new 
                                    Automobile_TDU__c(Id = sensor.Id, Account__c = newOpp.Shipment_Account__c,
                                                      Opportunity__c = newOpp.Id);
                                tduListtoUpdate.add(AutomobileTDUSensorForUpdate);
                            }
                        }
                        if(mapOfOppwithAutomobileTagSensor.size() >0) {
                            for(Automobile_Tag__c sensor : mapOfOppwithAutomobileTagSensor.values()) {
                                Automobile_Tag__c AutomobileTagSensorForUpdate = new 
                                    Automobile_Tag__c(Id = sensor.Id, Account__c = newOpp.Shipment_Account__c,
                                                      Opportunity__c = newOpp.Id);
                                tagListtoUpdate.add(AutomobileTagSensorForUpdate);
                            }
                        }
                    }
                    else if(newOpp.StageName == 'Return to Customer') {
                        if(mapOfOppwithAutomobileSensor.size() >0) {
                            for(Automobile_Sensor__c sensor : mapOfOppwithAutomobileSensor.values()) {
                                if(sensor.Account__c == newOpp.Shipment_Account__c) {
                                    Automobile_Sensor__c AutomobileSensorForUpdate = new 
                                        Automobile_Sensor__c(Id = sensor.Id, Account__c = newOpp.AccountId,
                                                             Opportunity__c = newOpp.Id);
                                    sensorListtoUpdate.add(AutomobileSensorForUpdate);
                                }
                            }  
                        }
                        if(mapOfOppwithAutomobilePresenceSensor.size() >0) {
                            for(Automobile_Presence_Sensor__c sensor : mapOfOppwithAutomobilePresenceSensor.values()) {
                                Automobile_Presence_Sensor__c AutomobilePresenceSensorForUpdate = new 
                                    Automobile_Presence_Sensor__c(Id = sensor.Id, Account__c = newOpp.AccountId,
                                                                  Opportunity__c = newOpp.Id);
                                presenceSensorListtoUpdate.add(AutomobilePresenceSensorForUpdate);
                            }
                        }
                        if(mapOfOppwithAutomobileTDUSensor.size() >0) {
                            for(Automobile_TDU__c sensor : mapOfOppwithAutomobileTDUSensor.values()) {
                                Automobile_TDU__c AutomobileTDUSensorForUpdate = new 
                                    Automobile_TDU__c(Id = sensor.Id, Account__c = newOpp.AccountId,
                                                      Opportunity__c = newOpp.Id);
                            }
                        }
                        if(mapOfOppwithAutomobileTagSensor.size() >0) {
                            for(Automobile_Tag__c sensor : mapOfOppwithAutomobileTagSensor.values()) {
                                Automobile_Tag__c AutomobileTagSensorForUpdate = new 
                                    Automobile_Tag__c(Id = sensor.Id, Account__c = newOpp.AccountId,
                                                      Opportunity__c = newOpp.Id);
                                tagListtoUpdate.add(AutomobileTagSensorForUpdate);                            
                            }
                        }
                    }
                }
            }
            //Automonile Records Insertion
            if(sensorListtoInsert.size() >0) {
                listsObjectsToInsert.addAll(sensorListtoInsert);
            }
            if(presenceSensorListtoInsert.size() >0) {
                listsObjectsToInsert.addAll(presenceSensorListtoInsert);
            }
            if(tduListtoInsert.size() >0) {
                listsObjectsToInsert.addAll(tduListtoInsert);
            }
            if(tagListtoInsert.size() >0) {
                listsObjectsToInsert.addAll(tagListtoInsert);
            }
            try {
                if(listsObjectsToInsert.size()>0){
                    insert listsObjectsToInsert;
                }
            }catch(DmlException e) {
                System.debug(e.getMessage());
            }
            // Automible Records Updation
            if(sensorListtoUpdate.size() >0) {
                listsObjectsToUpdate.addAll(sensorListtoUpdate);
            }
            if(presenceSensorListtoUpdate.size() >0) {
                listsObjectsToUpdate.addAll(presenceSensorListtoUpdate);
            }
            if(tduListtoUpdate.size() >0) {
                listsObjectsToUpdate.addAll(tduListtoUpdate);
            }
            if(tagListtoUpdate.size() >0) {
                listsObjectsToUpdate.addAll(tagListtoUpdate);
            }
            try {
                if(listsObjectsToUpdate.size()>0){
                    update listsObjectsToUpdate;
                }
            }catch(DmlException e) {
                System.debug(e.getMessage());
            }
        }
    }
    // Sending Mail Notification
    public static void sendEmail(List<Opportunity> newOppList){
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        //Invalid sensor's list
        List<String> invalidSensorName = new List<String>();
        for(Opportunity opp : mapOfOppwithId.values()) {
            Set<String> sensorSetName = mapOfOppwithSensors.get(opp.Id);
            //Insitialization to mailing method
            Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage(); 
            String[] toAddress = new String[]{opp.OwnerId};
                emailMsg.setToAddresses(toAddress);
            String emailSub = opp.Name+' '+opp.CreatedDate; //Email Subject
            emailMsg.setSubject(emailSub);
            String disName = 'Aryan Sharma'; //Display Name
            emailMsg.setSenderDisplayName(disName);
            //Content or Body of the Email
            String content ='';
            content ='Dear '+' Aryan Sharma'+',<br/>';
            content +='Sensor shipment process is completed. Please refer below mentioned details to get all the'+' '+ 
                'success and failure details. <br/><br/>';            
            if(sensorSetName.size()>0){
                content +='<font size = "4">'+'Successful:'+'</font><br/><br/>';
                content +='<table border="1" cellpadding = "10" cellspacing = "10" style="border-collapse:collapse">'+' '+
                    '<tr height = "35" align="center"><th>'+'Automobile Type'+'</th><th>'+'Name'+
                    '</th><th>'+'Message'+'</th></tr>';
                for(String str : sensorSetName) {
                    String name = (str.length()>18) ? str.substring(0, 18) : str;
                    if(name.startsWith('00:11:CE:00:')){
                        content +='<tr height = "45" align="center"><td>'+'Sensor'+'</td><td>'+name+
                            '</td><td>'+'Sensor inserted under Installation account '+opp.Account.Name+'</td></tr>';
                    }
                    else if(name.startsWith('00:11:CE:D:')) {
                        content +='<tr height = "45" align="center"><td>'+'Presence_Sensor'+'</td><td>'+name+
                            '</td><td>'+'Presece Sensor inserted under Installation account '+opp.Account.Name+'</td></tr>';
                    }  
                    else if(name.startsWith('00:11:CE:E:')){
                        content +='<tr height = "45" align="center"><td>'+'TDU_Sensor'+'</td><td>'+name+
                            '</td><td>'+'TDU Sensor inserted under Installation account '+opp.Account.Name+'</td></tr>';
                    }
                    else if(name.substring(0,3).isNumeric()) {
                        content +='<tr height = "45" align="center"><td>'+'Tag_Sensor'+'</td><td>'+name+
                            '</td><td>'+'Tag Sensor inserted under Installation account '+opp.Account.Name+'</td></tr>';
                    }
                    else {
                        invalidSensorName.add(name);
                    }
                }
                content+='</table><br/><br/>';
            }
            if(invalidSensorName.size()>0) { 
                content +='<font size = "4">'+'Unsuccessful:'+'</font><br/><br/>';
                content +='<table border="1" cellpadding = "10" cellspacing = "10" style="border-collapse:collapse">'+' '+
                    '<tr height = "35" align="center"><th>'+'Automobile Type'+'</th><th>'+'Name'+
                    '</th><th>'+'Message'+'</th></tr>';
                for(String str : invalidSensorName) {
                    content +='<tr height = "45" align="center"><td>'+'Sensor'+'</td><td>'+str+
                        '</td><td>'+'Invalid Sensors'+'</td></tr>';
                }
                content+='</table><br/><br/>';
            }
            emailMsg.setHtmlBody(content);
            emailList.add(emailMsg);   
        }
        //Send the email what we have created
        Messaging.sendEmail(emailList);
    }
}
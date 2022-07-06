public with sharing class PracticeDateTimeClass {
    public PracticeDateTimeClass() {
        // debug the current date
        DateTime myDateTime1 = DateTime.newInstance(2000,08,28,06,05,48);
        System.debug(myDateTime1);
        
        // add Specified number of days -- like: 2 days
        DateTime myDateTime2 = myDateTime1.addDays(2);
        System.debug(myDateTime2);
        
        // add specified number of hours -- like: 4 hours
        DateTime myDateTime3 = myDateTime1.addHours(4);
        System.debug(myDateTime3);
        
        // add specified number of minute -- like: 20 minutes
        DateTime myDateTime4 = myDateTime1.addMinutes(20);
        System.debug(myDateTime4);
        
        // add specified number of second -- like: 2 seconds
        DateTime myDateTime5 = myDateTime1.addSeconds(2);
        System.debug(myDateTime5);
        
        // add Specified number of months -- like: 3 months
        DateTime myDateTime6 = myDateTime1.addMonths(3);
        System.debug(myDateTime6);
        
        // Format of date and times
        Datetime myDT = DateTime.newInstance(2022, 5, 4, 19, 37, 55);
        String myDate = myDT.format('yyyy-MM-dd h:mm a');
        String expected = '2022-05-04 7:37 PM';
        System.debug(myDate);
        System.debug(expected);
    }
}
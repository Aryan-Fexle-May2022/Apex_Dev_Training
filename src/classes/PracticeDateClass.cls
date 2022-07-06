public with sharing class PracticeDateClass {
    public PracticeDateClass() {
        // debug the current date
        Date myDate1 = Date.newInstance(2000,08,28);
        System.debug(myDate1);

        // add 2 Days more to myDate1 
        Date myDate2 = myDate1.addDays(2);
        System.debug(myDate2);

        // add 2 months more to myDate1
        Date myDate3 = myDate1.addMonths(2);
        System.debug(myDate3);

        // add 2 years more to myDate1
        Date myDate4 = myDate1.addYears(2);
        System.debug(myDate4);

        // return the day-of-month component
        Integer myDate5 = myDate1.day();
        System.debug(myDate5);

        // return the day-of-year component
        Integer myDate6 = myDate1.dayOfYear();
        System.debug(myDate6);
    }
}
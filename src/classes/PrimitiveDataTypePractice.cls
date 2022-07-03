public with sharing class PrimitiveDataTypePractice {
    // Understanding about Boolean Data Type
    public void learnBooleanDataType(Boolean input) {
        Boolean isWinner = input;
        if(isWinner==false) {
            System.debug('He/She is not a winner!!');
        }
        else {
            System.debug('Yes, He/She is a Winner!!');
        }
    }
    // Understanding about Integer, Double, Decimal, Long
    public void learnMoreDataTypes() {
        Integer input1 = 100;
        Double input2 = 10.5;
        Double input3 = 25;
        Decimal input4 = 12.52;
        Long input5 = 587154845;
        //Integer input5 = 5484571544; // It gives error because input5 excceds the Integer's size
        System.debug(input1);
        System.debug(input2);
        System.debug(input3);
        System.debug(input4);   
        System.debug(input5);  
    } 
}
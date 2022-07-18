public with sharing class ExampleJSon {
    public ExampleJSon() {
        Datetime dt = Datetime.newInstance(
               Date.newInstance(2011, 3, 22),
               Time.newInstance(1, 15, 18, 0)); 
        String str = JSON.serialize(dt); 
        // System.assertEquals(
        // '"2011-03-22T08:15:18.000Z"',
        // str);
        System.debug('"2011-03-22T08:15:18.000Z"');
        System.debug(str);
    }
}

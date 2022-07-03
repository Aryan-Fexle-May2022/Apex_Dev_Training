public with sharing class PracticeStringClass {
    public PracticeStringClass() {
        // Unsing abbreaviate method to lower the size of string
        String string1 = 'Hello World';
        String string2 = string1.abbreviate(8);
        System.debug('Length: ' +string1.length()+ ' String1: '+ string1);
        System.debug('Length: ' +string2.length()+ ' String2: '+ string2);
        
        // lowerCase method
        String string3 = string1.toLowerCase();
        System.debug('toLowerCase: ' +string3);
        
        // upperCase method
        String string4 = string1.toUpperCase();
        System.debug('toUpperCase:' +string4);
        
        // return first letter capital unsing capitalize() method
        String string5 = string1.capitalize();
        System.debug('capitalize: '+string5);
        
        // return value of specified index
        System.debug('value at Index: '+string1.charAt(0));
        
        // CommpareTo() method using to compare strings lexicographically, 
        //unicode way
        String st1 = 'abcde';
        String st2 = 'abcd';
        System.debug('CompateTo: '+st1.compareTo(st2));
        
        // Return ture if method contains the specified sequence of 
        // characters in substring unsing contains(tostring)
        String st3 = 'Hello World';
        String st4 = 'llo'; 
        String st5 = 'eli'; 
        System.debug('Contains: '+st3.contains(st4)); // true
        System.debug('Contains: '+st3.contains(st5)); // false
        
        // containsWhitespace() method return true if the string contains whitespaces
        System.debug('containsWhitespace: '+st3.containsWhitespace());
        System.debug('containsWhitespace: '+st4.containsWhitespace());
        
        // substring(startIndex) method from starting index
        String s1 = 'hamburger';
        System.debug(s1);
        System.debug('s1 starts from index 3: '+s1.substring(3));
        
        // substring(startIndex, endIndex) mthod from starting to ending index
        System.debug('s1 starts from index 3 and ends at 5: '+s1.substring(3, 5));
    }
}
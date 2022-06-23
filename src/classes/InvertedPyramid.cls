public with sharing class InvertedPyramid {
    public InvertedPyramid(Integer input) {
        for(Integer i=1;i<=input;i++) {
            String s = ' ';
            for(Integer j=1;j<=i-1;j++) {
               s = s + '_';
            }
            for(Integer j=1;j<=2*(input-i)+1;j++){
                s = s + '*';
            }
            for(Integer j=1;j<=i-1;j++) {
                s = s + '_';
            }
            System.debug(s);
        } 
    }
}
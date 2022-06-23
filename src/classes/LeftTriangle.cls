public with sharing class LeftTriangle {
    public LeftTriangle(Integer input) {
        for(Integer i=1;i<=input;i++) {
            String s = ' ';
            for(Integer j=1;j<=i;j++) {
                s = s + '*';
            }
            System.debug(s);
        }
    }
}
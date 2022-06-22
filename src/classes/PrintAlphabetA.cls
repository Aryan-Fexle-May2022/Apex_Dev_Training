public class PrintAlphabetA {
    public PrintAlphabetA() {
        Integer k=2,t=2;
        Boolean m = true;
        for(Integer i=1;i<=6;i++) {
            String s='  ';
            if(i==2){k--; t++;}
            for(Integer j=1;j<=3;j++){
                if((i==2||i>=4) && j==2){m=false;}else{m=true;}
                
                if(j>=k && j<=t && m ){
                    s = s + '*';  
                }
                else {
                    s = s + '_';
                }
            }
            System.debug(s);
        }
    }
}
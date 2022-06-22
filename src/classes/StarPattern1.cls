public class StarPattern1 {
    public void printStar(){
        for(Integer i=1;i<=5;i++) {
            String s='  ';
            for(Integer j=1;j<=5;j++) {
                if(j>=6-i)
                {
                    s = s + '*';
                }
                else
                {
                    s = s + '_';
                }
            }
            System.debug(s); 
        }
    }
}
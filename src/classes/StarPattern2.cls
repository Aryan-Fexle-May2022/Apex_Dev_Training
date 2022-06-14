public class StarPattern2 {
    public StarPattern2(Integer n) {
        for(Integer i=0;i<=n;i++) {
            String s = ' ';
            for(Integer j=0;j<=n;j++) {
                //System.debug('*');
                s= s + '*';
            }
            System.debug(s);
        }
    }
}
public class RightUpDownTriangle {
    public RightUpDownTriangle(Integer n) {
        Integer a =n;
        for(Integer i=1;i<=n;i++) {
            String s = ' ';
            if(i<=n/2+1) {
                for(Integer j=i;j<=n/2;j++) {
                    s = s +'_';
                }
                
                for(Integer j=1;j<=i;j++) {
                    s = s + '*';
                }
            }
            else {
                for(Integer j=1;j<=i-n/2-1;j++) {
                    s = s + '_';
                }
                for(Integer j=1;j<=a/2;j++) {
                    s = s + '*';
                }
                a = a - 2;
            }
            System.debug(s);
           
        }
    }
}
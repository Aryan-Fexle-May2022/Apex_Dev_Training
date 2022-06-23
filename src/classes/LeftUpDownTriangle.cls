// Left Pascal's Triangle
public class LeftUpDownTriangle {
    public LeftUpDownTriangle(Integer n) {
        Integer a = n;
        for(Integer i=1;i<=(n);i++) {
            String s = ' ';
            if(i<=n/2+1) {
                for(Integer j=1;j<=i;j++) {
                    s = s + '*';
                }
            }
            else {
                for(Integer j=a/2;j>=1;j--) {
                    s = s + '*'; 
                }
               a = a-2;
            }
            System.debug(s);
        }
    }
}
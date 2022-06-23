public class TriangleStarPattern {
    public TriangleStarPattern() {
        for(Integer i=1;i<=5;i++) {
            String s = ' ';
            if(i==1) {
                for(Integer j=1;j<=9;j++) {
                    s = s + '*';
                } 
            }
            else {
                for(Integer j=1;j<=9;j++) {
                    if(i==j || i+j==10) {
                        s = s + '*';
                    }
                    else {
                        s = s + '_';
                    }
                }
            }
            System.debug(s);
        }
    }
}
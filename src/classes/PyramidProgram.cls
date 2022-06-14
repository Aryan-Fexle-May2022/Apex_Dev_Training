public class PyramidProgram {
    public PyramidProgram(Integer row){ 
        for(Integer i=1;i<=row;i++) {
            String star = '';
            //print space
            for(Integer j=1;j<=row-i;j++) {
                star = star + ' _ ';                 
            } 
            // Print star
            for(Integer j=1;j<=2*i-1;j++) {
                star = star + ' * ';
            }
            // print space
            for(Integer j=1;j<=row-i;j++) {
                star = star + ' _ ';                 
            }
            System.debug(star);
        }
    }
}
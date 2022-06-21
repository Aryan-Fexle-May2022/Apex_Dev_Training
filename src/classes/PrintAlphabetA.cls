public class PrintAlphabetA {
    public PrintAlphabetA() {
        integer k=2,t=2;
        boolean m = true;
        for(integer i=1;i<=6;i++)
        {
            string s='  ';
            if(i==2){k--; t++;}
            for(integer j=1;j<=3;j++)
            {
                if((i==2||i>=4) && j==2){m=false;}else{m=true;}
                
                if(j>=k && j<=t && m )
                {
                    s = s + 'x';  
                }
                else
                {
                    s = s + '_';
                }
                
            }
            system.debug(s);
            
        }
    }
}
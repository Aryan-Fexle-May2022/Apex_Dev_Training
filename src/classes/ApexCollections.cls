public class ApexCollections {
    public ApexCollections() {
        Set<Integer> mySet = new Set<Integer>();
        mySet.add(1);
        mySet.add(3);
        System.assert(mySet.contains(1)); 
        //mySet.remove(1);
        System.debug(mySet);
    }
}
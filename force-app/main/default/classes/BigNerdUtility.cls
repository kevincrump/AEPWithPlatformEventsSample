public with sharing class BigNerdUtility {
    public BigNerdUtility() {

    }

    public static Map<String,SObject> buildStringSObjectMap(List<SObject> sobjectList, Schema.DescribeFieldResult sdfr){
        Map<String,SObject> mo = new  Map<String,SObject>();
        for(SObject so:sobjectList){
            mo.put((String)so.get(sdfr.getName()), so);
        }
        return mo;
    }
}

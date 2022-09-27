public with sharing class LeadsDeDupeHelper {
    LeadsDeDupeHelper() {
       
    }
   public static List<Lead> dedupe(List<Lead> leads)  {
        system.debug('Lead Deduping...');
        List<Lead> dupes = new List<SObject>();
        List<Datacloud.FindDuplicatesResult> fdrList =Datacloud.FindDuplicates.findDuplicates(leads);
        system.debug('Lead Dupes: ' + fdrList.size());
        for(Datacloud.FindDuplicatesResult fdr:fdrList){
            Integer index = fdrList.indexOf(fdr);
            
            for(Datacloud.DuplicateResult dr : fdr.duplicateResults){
                system.debug(dr);
                Datacloud.MatchResult[] matchResults = dr.getMatchResults();
                system.debug('matchResults.size'+matchResults.size());
                Datacloud.MatchRecord[] matchRecords = matchResults[0].getMatchRecords();
                system.debug('matchRecords.size'+matchRecords.size());
                if(matchRecords.size()>0){
                    dupes.add(leads[index]);
                }
                // Add matched record to the duplicate records variable
                for (Datacloud.MatchRecord matchRecord : matchRecords) {
                    System.debug('MatchRecord: ' + matchRecord.getRecord());
                }
            }
        }
        Set<Lead> leadSet = new Set<Lead>(leads);
        if(dupes.size() > 0){
            leadSet.removeAll( new Set<Lead>( dupes));
            system.debug('Dupes Detected: ' + dupes.size());
        }
        return new List<Lead>(leadSet);
    }
}

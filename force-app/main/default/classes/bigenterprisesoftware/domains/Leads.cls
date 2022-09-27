public with sharing class Leads 
extends ApplicationSObjectDomain
implements ILeads{
     
        public static ILeads newInstance(List<Lead> records)
        {
            return (ILeads) Application.Domain.newInstance(records);
        }
    
        public static ILeads newInstance(Set<Id> recordIds)
        {
            return (ILeads) Application.Domain.newInstance(recordIds);
        }
    
        public Leads(List<Lead> records)
        {
            
            super(records);
            system.debug('Leads Domain!!');
            List<Lead> dirtylist = new List<Lead>();
            // don't enforce CRUD security for Account records
            this.Configuration.disableTriggerCRUDSecurity();
            for(Lead l : records){
                if(l.Status == 'Auto'){
                    dirtylist.add(l);
                }
            }
            List<Database.LeadConvert > lcList = new  List<Database.LeadConvert >();
            //convert the lead
            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            for(Lead l : records){
                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(l.id);
                lc.setConvertedStatus(convertStatus.MasterLabel);
                lcList.add(lc);
            }
            List<Database.LeadConvertResult> lcrList = Database.convertLead(lcList);
            System.assert(lcrList[0].isSuccess());
        }
    
        public class Constructor
            implements fflib_SObjectDomain.IConstructable
        {
            public fflib_SObjectDomain construct(List<SObject> sObjectList)
            {
                return new Leads(sObjectList);
            }
        }
        public override void onApplyDefaults() {
            system.debug('onApplyDefaults executing...');
        }
        public override void onValidate() {
            system.debug('onValidate executing...');
        }
    }
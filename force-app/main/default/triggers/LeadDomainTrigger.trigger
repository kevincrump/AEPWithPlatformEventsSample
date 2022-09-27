trigger LeadDomainTrigger on Lead(
  after insert) {
   // Creates Domain class instance and calls appropriate methods
   fflib_SObjectDomain.triggerHandler(Leads.class);
}
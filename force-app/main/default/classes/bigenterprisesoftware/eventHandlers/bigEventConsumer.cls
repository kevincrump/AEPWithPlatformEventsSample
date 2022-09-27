public class BigEventConsumer extends PlatformEventAbstractConsumer{
    public override void runInProcess() {
        System.debug('------Big Event Consumer------');
        System.debug('#events:\n' + events.size());
        for(SObject pe: events){
            AT4DXMessage__e e = (AT4DXMessage__e)pe;
            System.debug('EventName__c : ' + e.EventName__c);
            System.debug('Category__c :  ' + e.Category__c);
            System.debug('Payload__c :   \n\n' + e.payload__c + '\n\n');
           
            BigEvent be = (BigEvent)Json.deserialize(e.payload__c, BigEvent.class);
            
            Type t = Type.forName(be.objectType);
            system.debug('type for name: ' + t);
            if(t == Account.class){
                Account a = (Account)be.sobj;
                system.debug(a);
                system.debug('NAME:' + a.Name);
                if(be.action == 'Create'){
                   AccountsService.createWithName(a.Name);
                }
            }
            if(t == Contact.class){
                Contact c = (Contact)be.sobj;
                system.debug(c);
                system.debug('EMAIL:' + c.email);
                if(be.action == 'Create'){
                   ContactsService.createContact(c.lastName,c.firstName,c.email);
                }
            }
            if(t == Lead.class){
                Lead l = (Lead)be.sobj;
                system.debug('LEAD:: ' + l);
                system.debug('EMAIL:' + l.email);
                if(be.action == 'Create'){
                  system.debug(':: CREATE --- LEAD :: ');
                  LeadsService.createLead( l.salutation, l.lastName, 
                  l.firstName, l.company, l.email,l.status );
                }
            }
        }
    }
    public class BigEvent{
        String action;
        String objectType;
        SObject sobj;
    }
}
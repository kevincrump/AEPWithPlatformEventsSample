public with sharing class LeadsSelector 
    extends ApplicationSObjectSelector
    implements ILeadsSelector{
        public static ILeadsSelector newInstance()
        {
            return (ILeadsSelector) Application.Selector.newInstance( Lead.SObjectType );
        }
    
        public Schema.sObjectType getSObjectType()
        {
            return Lead.SObjectType;
        }
    
        public override List<Schema.SObjectField> getSObjectFieldList()
        {
            return new List<Schema.SObjectField> {
                Lead.Id,
                Lead.Name,
                Lead.Email
            };
        }
    
        private List<Schema.SObjectField> getAdditionalSObjectFieldList()
        {
            return new List<Schema.SObjectField> {
                
            };
        }
    
        public List<Lead> selectByEmail( Set<String> emailSet)
        {
            return Database.query( newQueryFactory().setCondition( Lead.Email + ' in :emailSet').toSOQL() );
        }
    }

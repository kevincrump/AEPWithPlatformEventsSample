public with sharing class LeadsServiceImpl 
    implements ILeadsService
{
    public  LeadsServiceImpl() {

    }

    public void createLead( String salutation,String lastName, String firstName,String company, String email,String status )
    {
        // should validate status and default to open
        System.debug('LeadsServiceImpl.createLead method was called');
        Lead ld = new Lead(salutation = salutation,firstName = firstName,
        lastName=lastName,company = company, email=email, status = status);
        // check dupes
        // dedupe,log and return clean list
        List<Lead> autolist= LeadsDeDupeHelper.dedupe(new List<Lead>{ld});
        IApplicationSObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        system.debug('Executing as User: ' + UserInfo.getName());
        uow.registerNew( autolist) ;
        uow.commitWork();
       
    }
}


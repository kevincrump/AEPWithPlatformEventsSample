public with sharing class ContactsServiceImpl 
    implements IContactsService
{
    public ContactsServiceImpl() {

    }

    public void createContact( String lastName, String firstName, String email )
    {
        System.debug('ContacttsServiceImpl.createContact method was called');

        List<Contact> contactsFound = ContactsSelector.newInstance().selectByEmail( new Set<String>{ email } );
        IApplicationSObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        system.debug('Executing as User: ' + UserInfo.getName());
        if ( contactsFound.isEmpty() ) 
        {
            System.debug('No Contacts found with email  \'' + email + '\'.  Creating one now.');
            uow.registerNew( new Contact(firstName = firstName,lastName=lastName,email=email) );
            uow.commitWork();
        }
        else 
        {
            System.debug('Found Contact with email  \'' + email + '\'.  Creating a Lead!');
            
        }
    }
}

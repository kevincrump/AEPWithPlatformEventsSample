public class ContactsService 
{
    private static IContactsService service()
    {
        return (IContactsService) Application.Service.newInstance( IContactsService.class );
    }

    public static void createContact( String lastName, String firstName, String email )
    {
        System.debug('Calling IContactsService.createContact method');
        service().createContact( lastName,firstName,email );
    }
}

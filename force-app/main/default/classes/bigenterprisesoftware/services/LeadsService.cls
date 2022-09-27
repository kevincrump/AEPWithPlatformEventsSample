public class LeadsService 
{
    private static ILeadsService service()
    {
        return (ILeadsService) Application.Service.newInstance( ILeadsService.class );
    }

    public static void createLead( String salutation, String lastName, 
    String firstName, String company, String email, String status )
    {
        System.debug('Calling ILeadsService.createLead method');
        service().createLead( salutation,lastName,firstName, company,email,status );
    }
}

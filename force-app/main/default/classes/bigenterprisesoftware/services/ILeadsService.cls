public interface ILeadsService {
    void createLead( String salutation, 
        String lastName, 
        String firstName, 
        String company, 
        String email, 
        String status );
}

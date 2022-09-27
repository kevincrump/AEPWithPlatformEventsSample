public Interface ILeadsSelector 
extends IApplicationSObjectSelector{
    List<Lead>  selectByEmail(Set<String> emailSet);
}

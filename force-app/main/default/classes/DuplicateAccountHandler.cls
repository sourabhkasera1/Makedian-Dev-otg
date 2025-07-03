public class DuplicateAccountHandler {
    //The following trigger will fire when we try to create or update an Account with same name 
    //i.e. preventing the users to create duplicate Accounts
    Public static void DuplicateInsertion(List<Account> Accountlist)
    {
		Set<id> AccountId=new Set<id>();
        for(Account ac: Accountlist)
        {
            AccountId.add(ac.id);
        }
        
        List<Account> GetRecord=[Select id,Name From Account Where id=:AccountId];
    }

    
}
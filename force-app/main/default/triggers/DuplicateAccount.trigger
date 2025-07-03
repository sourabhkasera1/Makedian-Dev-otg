trigger DuplicateAccount on Account (before insert) {
    
    if(Trigger.isBefore || Trigger.isInsert)
    {
        DuplicateAccountHandler.DuplicateInsertion(Trigger.new);
    }
 
}
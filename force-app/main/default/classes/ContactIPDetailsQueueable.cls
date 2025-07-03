public class ContactIPDetailsQueueable implements Queueable, Database.AllowsCallouts {
    private Set<Id> contactIds;

    public ContactIPDetailsQueueable(Set<Id> contactIds) {
        this.contactIds = contactIds;
    }

    public void execute(QueueableContext context) {
        GetCurrentUserIPDetailsBatch batch = new GetCurrentUserIPDetailsBatch(contactIds);
        Database.executeBatch(batch, 1);
    }
}
trigger ContactPhoneUpdateOnParent on Contact (after insert, after update, before delete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            Set<Id> contactIds = new Set<Id>();
            for (Contact ct : Trigger.new) {
                contactIds.add(ct.Id);
            }
            System.enqueueJob(new ContactIPDetailsQueueable(contactIds));
        }
    }

    if (Trigger.isBefore) {
        if (Trigger.isDelete) {
            //ContactPhoneUpdateOnParentHandler.ContactAfterDelete(Trigger.old, Trigger.oldMap);
        }
    }
}
/**
 * {@link ApexTrigger} that is run during {@link Case_Review__c} DML operations.
 */
trigger CaseReviewTrigger on Case_Review__c(
  before insert,
  before update,
  before delete,
  after insert,
  after update,
  after delete,
  after undelete
) {
  TriggerHandlerRunner.run(Trigger.new, Trigger.oldMap, Trigger.operationType);
}
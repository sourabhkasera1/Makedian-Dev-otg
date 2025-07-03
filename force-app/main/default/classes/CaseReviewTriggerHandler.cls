/**
 * {@link TriggerHandler} for {@link Case_Review__c} DML operations.
 */
public with sharing class CaseReviewTriggerHandler extends NoOpTriggerHandler {
  @TestVisible
  private static CatsRepository catsRepository = CatsDeps.CATS_REPOSITORY;

  public override SObjectType getSObjectType() {
    return Case_Review__c.SObjectType;
  }

  public override void onBeforeInsert(List<SObject> sobjects) {
    List<Case_Review__c> caseReviews = (List<Case_Review__c>) sobjects;

    Id queueId = catsRepository.getQueueByDeveloperName(CatsDeps.DEFAULT_ASSIGNMENT_QUEUE);
    if (String.isBlank(queueId)) {
      throw new CaseReviewException(
        String.format(
          'Failed to assign Case Reviews to the default assignment queue. Queue {0} was not found.',
          new List<Object>{ CatsDeps.DEFAULT_ASSIGNMENT_QUEUE }
        )
      );
    }

    for (Case_Review__c caseReview : caseReviews) {
      caseReview.OwnerId = queueId;
    }
  }
}
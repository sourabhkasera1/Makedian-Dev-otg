/**
 * Tests for {@link CaseReviewTriggerHandler}.
 */
@IsTest(IsParallel=true)
private class CaseReviewTriggerHandlerTest {
  private static final CaseReviewTriggerHandler triggerHandler;
  private static final CatsRepositoryMock catsRepository;

  static {
    catsRepository = new CatsRepositoryMock();

    CaseReviewTriggerHandler.catsRepository = catsRepository;

    triggerHandler = new CaseReviewTriggerHandler();
  }

  @IsTest
  private static void onBeforeInsert_queueNotFound_throws() {
    catsRepository.when(catsRepository.method.getQueueByDeveloperName()).thenReturn(null);
    AssertThrows.Throwing throwing = AssertThrows.with(
      CaseReviewException.class,
      'Failed to assign Case Reviews to the default assignment queue. Queue Case_Review_Assignment was not found.'
    );

    try {
      triggerHandler.onBeforeInsert(new List<Case_Review__c>{ new Case_Review__c() });
    } catch (CaseReviewException e) {
      throwing.threw(e);
    }

    throwing.assertHasThrown();
    catsRepository.verify(catsRepository.method.getQueueByDeveloperName());
  }

  @IsTest
  private static void onBeforeInsert_queueFound_reassignsOwnerId() {
    Id groupId = SObjectUtil.generateFakeId(Group.SObjectType);
    catsRepository.when(catsRepository.method.getQueueByDeveloperName()).thenReturn(groupId);
    Case_Review__c caseReview = new Case_Review__c();

    triggerHandler.onBeforeInsert(new List<SObject>{ caseReview });

    Assert.areEqual(groupId, caseReview.OwnerId);
    catsRepository.verify(catsRepository.method.getQueueByDeveloperName());
  }
}
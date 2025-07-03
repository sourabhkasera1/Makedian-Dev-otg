/**
 * Tests for {@link CaseReviewTrigger}.
 */
@IsTest(IsParallel=true)
private class CaseReviewTriggerTest {
  @IsTest
  private static void runsTheTrigger() {
    new TriggerTest().run(new CaseReviewTriggerRunner());
  }

  private class CaseReviewTriggerRunner extends TriggerTest.TriggerRunner {
    private override void insertSObject() {
      insert new Case_Review__c();
    }
  }
}
/**
 * Tests for {@link SObjectIconSelectorController}.
 */
@IsTest(IsParallel=true)
private class SObjectIconSelectorControllerTest {
  @IsTest
  private static void getIcon_sobjectTypeHasNoIcon_throws() {
    String sobjectName = 'not an sobject name';
    AssertThrows.Throwing throwing = AssertThrows.with(
      IllegalArgumentException.class,
      'Expected to find 1 icon definition for SObjectType: not an sobject name. Found 0.'
    );

    try {
      SObjectIconSelectorController.getIcon(sobjectName);
    } catch (Exception e) {
      throwing.threw(e);
    }

    throwing.assertHasThrown();
  }

  @IsTest
  private static void getIcon_accountSObjectType_returnsIcon() {
    String sobjectName = Account.SObjectType.getDescribe().getName();

    String icon = SObjectIconSelectorController.getIcon(sobjectName);

    System.assertEquals('standard:account', icon);
  }
}
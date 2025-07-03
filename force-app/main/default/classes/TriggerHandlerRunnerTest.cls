/**
 * Tests for {@link TriggerHandlerRunner}.
 */
@IsTest(IsParallel=true)
private class TriggerHandlerRunnerTest {
  private static final TriggerHandlerProviderMock triggerHandlerProvider;
  private static final TriggerHandlerMock triggerHandler;

  static {
    triggerHandlerProvider = new TriggerHandlerProviderMock();
    triggerHandler = new TriggerHandlerMock();

    triggerHandlerProvider.when(triggerHandlerProvider.method.get())
      .thenReturn(new List<TriggerHandler>{ triggerHandler });

    TriggerHandlerRunner.triggerHandlerProvider = triggerHandlerProvider;
  }

  @IsTest
  private static void run_emptySObjectLists_throws() {
    List<SObject> sobjects = new List<SObject>();
    Map<Id, SObject> oldSObjectsByIds = new Map<Id, SObject>();
    TriggerOperation triggerOperation = TriggerOperation.BEFORE_INSERT;
    AssertThrows.Throwing throwing = AssertThrows.with(
      IllegalArgumentException.class,
      'Expected to get the SObjectType from the records in the trigger, but got null. Trigger.new contained 0 records and Trigger.oldMap contained 0 records.'
    );

    try {
      TriggerHandlerRunner.run(sobjects, oldSObjectsByIds, triggerOperation);
    } catch (Exception e) {
      throwing.threw(e);
    }

    throwing.assertHasThrown();
  }

  @IsTest
  private static void run_nullTriggerOperation_throws() {
    List<SObject> sobjects = new List<Account>{ new Account() };
    Map<Id, SObject> oldSObjectsByIds = new Map<Id, SObject>();
    TriggerOperation triggerOperation = null;
    AssertThrows.Throwing throwing = AssertThrows.with(
      IllegalArgumentException.class,
      'Attempted to run unexpected Trigger Operation: null'
    );

    try {
      TriggerHandlerRunner.run(sobjects, oldSObjectsByIds, triggerOperation);
    } catch (Exception e) {
      throwing.threw(e);
    }

    throwing.assertHasThrown();
  }

  @IsTest
  private static void run_beforeInsert_runsOnBeforeInsert() {
    List<SObject> sobjects = new List<SObject>{ new Account() };
    Map<Id, SObject> oldSObjectsByIds = new Map<Id, SObject>();
    TriggerOperation triggerOperation = TriggerOperation.BEFORE_INSERT;
    triggerHandler.when(triggerHandler.method.onBeforeInsert()).thenReturnVoid();

    TriggerHandlerRunner.run(sobjects, oldSObjectsByIds, triggerOperation);

    triggerHandler.verify(triggerHandler.method.onBeforeInsert());
  }

  @IsTest
  private static void run_beforeUpdate_runsOnBeforeUpdate() {
    Id accountId = SObjectUtil.generateFakeId(Account.SObjectType);
    List<SObject> sobjects = new List<SObject>{ new Account(Id = accountId) };
    Map<Id, SObject> oldSObjectsByIds = new Map<Id, SObject>{
      accountId => new Account(Id = accountId)
    };
    TriggerOperation triggerOperation = TriggerOperation.BEFORE_UPDATE;
    triggerHandler.when(triggerHandler.method.onBeforeUpdate()).thenReturnVoid();

    TriggerHandlerRunner.run(sobjects, oldSObjectsByIds, triggerOperation);

    triggerHandler.verify(triggerHandler.method.onBeforeUpdate());
  }

  @IsTest
  private static void run_beforeDelete_runsOnBeforeDelete() {
    Id accountId = SObjectUtil.generateFakeId(Account.SObjectType);
    List<SObject> sobjects = new List<SObject>();
    Map<Id, SObject> oldSObjectsByIds = new Map<Id, SObject>{
      accountId => new Account(Id = accountId)
    };
    TriggerOperation triggerOperation = TriggerOperation.BEFORE_DELETE;
    triggerHandler.when(triggerHandler.method.onBeforeDelete()).thenReturnVoid();

    TriggerHandlerRunner.run(sobjects, oldSObjectsByIds, triggerOperation);

    triggerHandler.verify(triggerHandler.method.onBeforeDelete());
  }

  @IsTest
  private static void run_afterInsert_runsOnAfterInsert() {
    List<SObject> sobjects = new List<SObject>{ new Account() };
    Map<Id, SObject> oldSObjectsByIds = new Map<Id, SObject>();
    TriggerOperation triggerOperation = TriggerOperation.AFTER_INSERT;
    triggerHandler.when(triggerHandler.method.onAfterInsert()).thenReturnVoid();

    TriggerHandlerRunner.run(sobjects, oldSObjectsByIds, triggerOperation);

    triggerHandler.verify(triggerHandler.method.onAfterInsert());
  }

  @IsTest
  private static void run_afterUpdate_runsOnAfterUpdate() {
    Id accountId = SObjectUtil.generateFakeId(Account.SObjectType);
    List<SObject> sobjects = new List<SObject>{ new Account(Id = accountId) };
    Map<Id, SObject> oldSObjectsByIds = new Map<Id, SObject>{
      accountId => new Account(Id = accountId)
    };
    TriggerOperation triggerOperation = TriggerOperation.AFTER_UPDATE;
    triggerHandler.when(triggerHandler.method.onAfterUpdate()).thenReturnVoid();

    TriggerHandlerRunner.run(sobjects, oldSObjectsByIds, triggerOperation);

    triggerHandler.verify(triggerHandler.method.onAfterUpdate());
  }

  @IsTest
  private static void run_afterDelete_runsOnAfterDelete() {
    Id accountId = SObjectUtil.generateFakeId(Account.SObjectType);
    List<SObject> sobjects = new List<SObject>();
    Map<Id, SObject> oldSObjectsByIds = new Map<Id, SObject>{
      accountId => new Account(Id = accountId)
    };
    TriggerOperation triggerOperation = TriggerOperation.AFTER_DELETE;
    triggerHandler.when(triggerHandler.method.onAfterDelete()).thenReturnVoid();

    TriggerHandlerRunner.run(sobjects, oldSObjectsByIds, triggerOperation);

    triggerHandler.verify(triggerHandler.method.onAfterDelete());
  }

  @IsTest
  private static void run_afterUndelete_runsOnAfterUndelete() {
    Id accountId = SObjectUtil.generateFakeId(Account.SObjectType);
    List<SObject> sobjects = new List<SObject>{ new Account(Id = accountId) };
    Map<Id, SObject> oldSObjectsByIds = new Map<Id, SObject>();
    TriggerOperation triggerOperation = TriggerOperation.AFTER_UNDELETE;
    triggerHandler.when(triggerHandler.method.onAfterUndelete()).thenReturnVoid();

    TriggerHandlerRunner.run(sobjects, oldSObjectsByIds, triggerOperation);

    triggerHandler.verify(triggerHandler.method.onAfterUndelete());
  }
}
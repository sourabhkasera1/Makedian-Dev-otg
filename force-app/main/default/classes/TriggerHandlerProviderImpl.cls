/**
 * Implementation of {@link TriggerHandlerProvider}.
 */
public inherited sharing class TriggerHandlerProviderImpl implements TriggerHandlerProvider {
  private List<ApexTypeImplementor> implementors;

  public List<TriggerHandler> get(SObjectType sobjectType) {
    if (implementors == null) {
      implementors = getApexTypeImplementors();
    }

    List<TriggerHandler> triggerHandlers = new List<TriggerHandler>();
    for (ApexTypeImplementor implementor : implementors) {
      TriggerHandler triggerHandler = buildTriggerHandler(implementor);
      if (triggerHandler.getSObjectType() == sobjectType) {
        triggerHandlers.add(triggerHandler);
      }
    }

    return triggerHandlers;
  }

  /**
   * Returns {@link ApexTypeImplementor}s that implement {@link TriggerHandler}.
   *
   * This is {@code @TestVisible} so that we can re-used it directly in
   * {@link TriggerHandlerProviderImplTest}.
   */
  @TestVisible
  private static List<ApexTypeImplementor> getApexTypeImplementors() {
    return [
      SELECT ClassNamespacePrefix, ClassName
      FROM ApexTypeImplementor
      WHERE InterfaceName = :TriggerHandler.class.getName() AND IsConcrete = TRUE
    ];
  }

  /**
   * Builds and returns a {@link TriggerHandler} from the given {@link ApexTypeImplementor}.
   *
   * This is {@code @TestVisible} so that we can re-used it directly in
   * {@link TriggerHandlerProviderImplTest}.
   */
  @TestVisible
  private static TriggerHandler buildTriggerHandler(ApexTypeImplementor implementor) {
    Type type = String.isNotBlank(implementor.ClassNamespacePrefix)
      ? Type.forName(implementor.ClassNamespacePrefix, implementor.ClassName)
      : Type.forName(implementor.ClassName);

    return (TriggerHandler) type.newInstance();
  }
}
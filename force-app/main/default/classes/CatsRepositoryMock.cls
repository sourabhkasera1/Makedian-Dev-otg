/**
 * {@link Mock} implementation of {@link CatsRepository}.
 */
@IsTest
public class CatsRepositoryMock extends Mock implements CatsRepository {
  public final Method method = new Method();

  public Id getQueueByDeveloperName(String developerName) {
    return (Id) mockedCall(
      method.getQueueByDeveloperName(),
      new Map<String, Object>{ 'developerName' => developerName }
    );
  }

  public class Method {
    public String getQueueByDeveloperName() {
      return new ExecutionInfo().getFullName();
    }
  }
}
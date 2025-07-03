/**
 * Tests for {@link CatsRepositoryImpl}.
 */
@IsTest(IsParallel=true)
private class CatsRepositoryImplTest {
  private static final CatsRepositoryImpl catsRepository;

  static {
    catsRepository = new CatsRepositoryImpl();
  }

  @IsTest
  private static void getQueueByDeveloperName_runsTheQuery() {
    String developerName = 'Developer Name';

    catsRepository.getQueueByDeveloperName(developerName);

    Assert.areEqual(1, Limits.getQueries());
  }
}
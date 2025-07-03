/**
 * Implementation of {@link CatsRepository}.
 */
public inherited sharing class CatsRepositoryImpl implements CatsRepository {
  public Id getQueueByDeveloperName(String developerName) {
    List<Group> groups = [SELECT Id FROM Group WHERE DeveloperName = :developerName LIMIT 1];
    return groups.size() == 1 ? groups[0].Id : null;
  }
}
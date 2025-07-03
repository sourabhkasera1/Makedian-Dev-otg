/**
 * Handles reading and writing data related to the CATS application.
 */
public interface CatsRepository {
  /**
   * Returns the id of the queue with the given developer name.
   */
  Id getQueueByDeveloperName(String developerName);
}
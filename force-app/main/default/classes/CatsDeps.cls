/**
 * Dependencies for the CATS application.
 */
public inherited sharing class CatsDeps {
  public static final CatsRepository CATS_REPOSITORY {
    get {
      return new CatsRepositoryImpl();
    }
    set;
  }

  public static final String DEFAULT_ASSIGNMENT_QUEUE {
    get {
      return 'Case_Review_Assignment';
    }
    set;
  }
}
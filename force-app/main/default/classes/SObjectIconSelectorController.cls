/**
 * Apex logic for {@link c-s-object-icon-selector}.
 */
public inherited sharing class SObjectIconSelectorController {
  /**
   * Returns the icon that is configured for the given SObject name.
   *
   * The icon is returns as a {@link String} that can be directly used in a Lightning Web
   * Component. For example, it will return something like: {@code custom:custom18}.
   */
  @AuraEnabled(Cacheable=true)
  public static String getIcon(String sobjectName) {
    List<IconDefinition> iconDefinitions = [
      SELECT Url
      FROM IconDefinition
      WHERE TabDefinition.SobjectName = :sobjectName AND Url LIKE '%.svg'
    ];
    Preconditions.checkArgument(
      iconDefinitions.size() == 1,
      String.format(
        'Expected to find 1 icon definition for SObjectType: {0}. Found {1}.',
        new List<Object>{ sobjectName, iconDefinitions.size() }
      )
    );

    // Example IconDefinition Url:
    // https://page-ruby-6279.scratch.my.salesforce.com/img/icon/t4v35/custom/custom18.svg
    String url = iconDefinitions[0].Url;

    List<String> urlParts = url.split('/');
    String type = urlParts[urlParts.size() - 2];
    String name = urlParts[urlParts.size() - 1].removeEnd('.svg');

    return String.format('{0}:{1}', new List<Object>{ type, name });
  }
}
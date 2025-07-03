/**
 * Apex logic for {@link c-case-codes}.
 */
public inherited sharing class CaseCodesController {
  @AuraEnabled(Cacheable=true)
  public static List<SObject> getCaseCodes(Id caseReviewId, String type) {
    if (type == CaseCodeConstants.TYPE_CPT) {
      return getCptCodes(caseReviewId);
    } else if (type == CaseCodeConstants.TYPE_DIAGNOSIS) {
      return getDiagnosisCodes(caseReviewId);
    } else if (type == CaseCodeConstants.TYPE_PROCEDURE) {
      return getProcedureCodes(caseReviewId);
    } else {
      throw new IllegalArgumentException(
        String.format('Failed to get Case Codes for Type {0}.', new List<Object>{ type })
      );
    }
  }

  // TODO: move these into CatsRepository
  private static List<CPT_Code__c> getCptCodes(Id caseReviewId) {
    return [
      SELECT Id, Name, Date_of_Service__c, Rate_Center_Code__c, Units_of_Service__c
      FROM CPT_Code__c
      WHERE Case_Review__c = :caseReviewId
    ];
  }

  private static List<Diagnosis_Code__c> getDiagnosisCodes(Id caseReviewId) {
    return [SELECT Id, Name, POA__c FROM Diagnosis_Code__c WHERE Case_Review__c = :caseReviewId];
  }

  private static List<Procedure_Code__c> getProcedureCodes(Id caseReviewId) {
    return [
      SELECT Id, Name, Procedure_Date__c
      FROM Procedure_Code__c
      WHERE Case_Review__c = :caseReviewId
    ];
  }
}
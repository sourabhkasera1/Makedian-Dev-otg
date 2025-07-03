public class CreateRecordFromLWC {
    @AuraEnabled(cacheable=true)
    public static List<String> getSObjectNames() {
        List<String> sObjectNames = new List<String>();
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        
        for (Schema.SObjectType sObjectType : globalDescribe.values()) {
            String objectName = sObjectType.getDescribe().getName();
            If(objectName == 'Account' || objectName == 'Contact' || objectName == 'Lead' || objectName == 'Opportunity')
            {
                sObjectNames.add(objectName);
                System.debug('SObject API Name => ' + objectName);
            }
            
        }
        
        System.debug('Final List of SObject Names => ' + sObjectNames);
        return sObjectNames;
    }
}
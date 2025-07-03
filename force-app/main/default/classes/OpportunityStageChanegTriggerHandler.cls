public class OpportunityStageChanegTriggerHandler {
    public static void OpptyStageChanger(List<Opportunity> OpptyList)
    {
        List<Opportunity> opptyStageValidation= new List<Opportunity>();
        for(Opportunity op : OpptyList)
        {
            Opportunity opptIn=new Opportunity();  
            If(op.StageName != 'Qualification')
            {
                system.debug('op  '+op.StageName);
                op.StageName.addError('User cannot change the stage Qualification to another stage');
               
                
            }
        }
        
    }
}
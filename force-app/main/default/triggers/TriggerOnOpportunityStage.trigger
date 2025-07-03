trigger TriggerOnOpportunityStage on Opportunity (before insert , before update) {
		OpportunityStageChanegTriggerHandler.OpptyStageChanger(Trigger.New);
}
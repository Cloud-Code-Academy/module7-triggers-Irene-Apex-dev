trigger OpportunityTrigger on Opportunity (before update, before delete) {

    if (Trigger.isUpdate) {
        for (Opportunity opportunity : Trigger.new) {

            if (opportunity.Amount <= 5000 && trigger.isBefore) {
            opportunity.addError('Opportunity amount must be greater than 5000');
            }

        }

    if (Trigger.isDelete) {
        for (Opportunity opportunity : Trigger.old) {

            if (opportunity.StageName == 'Closed Won') {
                opportunity.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }



}
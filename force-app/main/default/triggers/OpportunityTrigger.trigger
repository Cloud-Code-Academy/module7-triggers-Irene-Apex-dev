trigger OpportunityTrigger on Opportunity (before update, before delete) {

    for (Opportunity opportunity : Trigger.new) {
        if (opportunity.Amount <= 5000 && trigger.isBefore) {
            opportunity.addError('Opportunity amount must be greater than 5000');
        }
    }

    for (Opportunity opportunity : Trigger.old) {
        if (opportunity.IsWon == true && opportunity.Account.Industry == 'Banking' && trigger.isDelete) {
            opportunity.addError('Cannot delete closed opportunity for a banking account that is won');
        }
    }

}

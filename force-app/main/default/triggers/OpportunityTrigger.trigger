trigger OpportunityTrigger on Opportunity (before update) {

    for (Opportunity opportunity : Trigger.new) {
        if (opportunity.Amount <= 5000 && trigger.isBefore) {
            opportunity.addError('Opportunity amount must be greater than 5000');
        }

        

    }

}
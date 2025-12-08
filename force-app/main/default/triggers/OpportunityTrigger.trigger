trigger OpportunityTrigger on Opportunity (before update, before delete) {

    List<Contact> contacts = [
        SELECT Id, AccountId
        FROM Contact
        WHERE Title = 'CEO'
    ];

    Map<Id, Contact> contactsMap = new Map<Id, Contact>();

    for (Contact contact : contacts) {
        contactsMap.put(contact.AccountId, contact);
    }


    if (Trigger.isUpdate) {
        for (Opportunity opportunity : Trigger.new) {

            if (opportunity.Amount <= 5000 && Trigger.isBefore) {
            opportunity.addError('Opportunity amount must be greater than 5000');
            }

            if (opportunity.Primary_Contact__c == null && contactsMap.containsKey(opportunity.AccountId)) {
                opportunity.Primary_Contact__c = contactsMap.get(opportunity.AccountId).Id;
            }

        }
    }


    if (Trigger.isDelete) {

        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Industry = 'Banking'
        ];

        Map<Id, Account> accountsMap = new Map<Id, Account>(accounts);

        for (Opportunity opportunity : Trigger.old) {

            if (opportunity.StageName == 'Closed Won' && accountsMap.containsKey(opportunity.AccountId)) {
                opportunity.addError('Cannot delete closed opportunity for a banking account that is won');
            }

        }
    }
}
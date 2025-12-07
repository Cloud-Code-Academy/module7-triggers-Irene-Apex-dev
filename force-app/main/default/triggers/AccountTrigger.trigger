trigger AccountTrigger on Account (before insert, after insert) {

    if (Trigger.isBefore)

        for (Account account : Trigger.new) {

            if (account.Type == null) {
                account.Type = 'Prospect';
            } 

            if (account.ShippingStreet != null || account.ShippingPostalCode != null || account.ShippingCity != null || account.ShippingCountry != null) {
                account.BillingStreet = account.ShippingStreet;
                account.BillingPostalCode = account.ShippingPostalCode;
                account.BillingCity = account.ShippingCity;
                account.BillingState = account.ShippingState;
                account.BillingCountry = account.ShippingCountry;
            }

            if (account.Phone != null && account.Website != null && account.Fax != null) {
                account.Rating = 'Hot';
            }

        }

    if (Trigger.isAfter) {

        List<Contact> contacts = new List<Contact>();

        for (Account account : Trigger.new) {
            Contact contact = new Contact();
            contact.AccountId = account.Id;
            contact.LastName = 'DefaultContact';
            contact.Email = 'default@email.com';
            contacts.add(contact);
        }

        insert contacts;

    }  

}
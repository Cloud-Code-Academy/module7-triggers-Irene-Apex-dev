trigger AccountTrigger on Account (before insert) {

    for (Account account : Trigger.new) {

        if (Trigger.isBefore && account.Type == null) {
            account.Type = 'Prospect';
        } 

        if (Trigger.isBefore && (account.ShippingStreet != null || account.ShippingPostalCode != null || account.ShippingCity != null || account.ShippingCountry != null)) {
            account.BillingStreet = account.ShippingStreet;
            account.BillingPostalCode = account.ShippingPostalCode;
            account.BillingCity = account.ShippingCity;
            account.BillingState = account.ShippingState;
            account.BillingCountry = account.ShippingCountry;
        }

        if (Trigger.isBefore && account.Phone != null && account.Website != null && account.Fax != null) {
            account.Rating = 'Hot';
        }

        if (Trigger.isAfter) {
            Contact contact = new Contact();
            contact.Id = account.Id;
            contact.LastName = 'DefaultContact';
            contact.Email = 'default@email.com';
            insert contact;
        }

    }

}
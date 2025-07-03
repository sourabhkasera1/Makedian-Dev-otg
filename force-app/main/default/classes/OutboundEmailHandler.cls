public class OutboundEmailHandler {
    public static String SendEmailMethod()
    {
        try
        {
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            //OrgWideEmailAddress[] owea = [select Id,Address from OrgWideEmailAddress where Address = 'kaserasourabh77@gmail.com'];
            //system.debug('owea  '+owea);
            List<Contact> ListofContact = [select id,Email from Contact Where Email='sourabh.kasera@makedian.com'];
            for(Contact c : ListofContact)
            {
                //if ( owea.size() > 0 ) {
                        mail.setOrgWideEmailAddressId(system.label.OrgWideEmail);
                        system.debug('mail  '+mail);
                    //}
                    List<String> sendto=new List<String>();
                    //sendto.add(c.Email);
                    sendto.add('salesforctalview@s-1t7o20jrhbpcotvl567z79wrphq3if1tk4vzlfwj3wf7awr6n7.8i-8gjluay.cs221.apex.sandbox.salesforce.com');
                    mail.setToAddresses(sendto);
                    mail.setSubject(' Email Services ');
                    String body = 'Hello This is Testing Email';
                    mail.setHtmlBody(body);
                    mails.add(mail);
            }
            Messaging.sendEmail(mails);
            return 'Email Send Succesfully';
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            return 'Email Not Send';
        }
        
    }
}
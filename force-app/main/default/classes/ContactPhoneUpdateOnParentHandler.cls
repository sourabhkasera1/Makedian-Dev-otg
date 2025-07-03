public class ContactPhoneUpdateOnParentHandler {
    public static void ContactAfterInsert(List<Contact> TriggerConList)
    {
        List<Account> UpdatePhone = new List<Account>();
        for(Contact con : TriggerConList)
        {
            Account Ac=new Account();
            Ac.id = con.AccountId;
            Ac.Phone = Con.Phone;
            UpdatePhone.add(Ac);
        }
        system.debug('Account '+ UpdatePhone);
        if(UpdatePhone.size() > 0)
        {
            update UpdatePhone;            
        }
    }
    public static void ContactafterUpdate(List<Contact> TriggerConList, Map<id,Contact> TriggerConMap)
    {
        List<Account> UpdatePhone = new List<Account>();
        Map<id,Contact> ConOldMap =new Map<id,Contact>(TriggerConMap);
        for(Contact con : TriggerConList)
        {
            Account Ac=new Account();
            Ac.Id = con.AccountId;
            if(con.LastModifiedDate > ConOldMap.get(con.Id).LastModifiedDate && Con.Phone != ConOldMap.get(con.Id).Phone)
            {
                Ac.Phone = con.Phone;
            }
            UpdatePhone.add(Ac);
        }
        if(UpdatePhone.size() > 0)
        {
            update UpdatePhone;            
        }
    }
    public static void ContactAfterDelete(List<Contact> TriggerConList, Map<id,Contact> TriggerConMap)
    {//it is not working
        List<Account> UpdatePhone = new List<Account>();
        List<id> AccId=new List<id>();
        Datetime ConLastModiDate;
        system.debug('Trigger Old '+TriggerConList);
        for(Contact c: TriggerConList)
        {
            AccId.add(c.AccountId);
            ConLastModiDate=c.LastModifiedDate;
            system.Debug(ConLastModiDate);
        }
        list<Datetime> remaningLastMod = new list<Datetime>();
        List<Contact> ContactList=[Select id,LastModifiedDate,AccountId,Phone From Contact Where AccountId=:AccId];
        system.debug('List Old Map '+ ContactList);
        Datetime LargeMod;
        for(Contact c : ContactList)
        {
            remaningLastMod.add(c.LastModifiedDate);
            remaningLastMod.sort();
            for(integer i=1;i<remaningLastMod.size();i++)
            {
                if(remaningLastMod.size()==i+1)
                {
                    LargeMod=remaningLastMod.get(i);
                }
				system.debug('LargeMod  '+LargeMod + '  ===============    LastModifiedDate      '+c.LastModifiedDate);                
            }
            if(c.LastModifiedDate == LargeMod)
            {
                Account Ac = new Account();
                Ac.id=c.AccountId;
              	Ac.Phone = c.Phone;
                UpdatePhone.add(Ac);
                system.Debug('Account Phonee '+Ac);
            }  
        }
        if(UpdatePhone.size() > 0)
        {
            update UpdatePhone;            
        }
    }
}
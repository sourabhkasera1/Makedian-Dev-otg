public without sharing class GetCurrentUserIPDetailsBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
    
    public class IPDetails {
        public String ip { get; set; }
        public String continent_code { get; set; }
        public String continent_name { get; set; }
        public String country_code2 { get; set; }
        public String country_code3 { get; set; }
        public String country_name { get; set; }
        public String country_name_official { get; set; }
        public String country_capital { get; set; }
        public String state_prov { get; set; }
        public String state_code { get; set; }
        public String district { get; set; }
        public String city { get; set; }
        public String zipcode { get; set; }
        public String latitude { get; set; }
        public String longitude { get; set; }
        public Boolean is_eu { get; set; }
        public String calling_code { get; set; }
        public String country_tld { get; set; }
        public String languages { get; set; }
        public String country_flag { get; set; }
        public String geoname_id { get; set; }
        public String isp { get; set; }
        public String connection_type { get; set; }
        public String organization { get; set; }
        public String country_emoji { get; set; }
        public CurrencyInfo curen { get; set; }
        public TimeZoneInfo time_zone { get; set; }
    }
    
    public class CurrencyInfo {
        public String code { get; set; }
        public String name { get; set; }
        public String symbol { get; set; }
    }
    
    public class TimeZoneInfo {
        public String name { get; set; }
        public Decimal offset { get; set; }
        public Decimal offset_with_dst { get; set; }
        public String current_time { get; set; }
        public Decimal current_time_unix { get; set; }
        public Boolean is_dst { get; set; }
        public Decimal dst_savings { get; set; }
        public Boolean dst_exists { get; set; }
        public String dst_start { get; set; }
        public String dst_end { get; set; }
    }
    
    private Set<Id> contactIds;

    public GetCurrentUserIPDetailsBatch(Set<Id> contactIds) {
        this.contactIds = contactIds;
    }

    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, SourceIp FROM AuthSession WHERE UsersId = :UserInfo.getUserId() LIMIT 1]);
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<AuthSession> userIP = (List<AuthSession>) scope;
        String sourceIP = userIP.isEmpty() ? null : userIP[0].SourceIp;
        System.debug('sourceIP' + sourceIP);
        
        List<IP__c> ApiKey = IP__c.getAll().values();
        System.debug('ApiKey' + ApiKey[0].Api_Key__c);
        
        String Endpoint = 'https://api.ipgeolocation.io/ipgeo?apiKey=' + ApiKey[0].Api_Key__c + '&ip=' + sourceIP;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(Endpoint);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        System.debug('response  ' + response);
        System.debug(' ==  response.getBody()  ==  ' + response.getBody());
        
        List<Contact> contactList = new List<Contact>();
        if (response.getStatusCode() == 200) {
            IPDetails details = (IPDetails) JSON.deserialize(response.getBody(), IPDetails.class);
            
            System.debug('IP details: ' + details);
            System.debug('IP: ' + details.ip);
            System.debug('Country: ' + details.country_name);
            System.debug('Continent: ' + details.continent_name);
            System.debug('Currency: ' + details.curen);
            System.debug('Time Zone: ' + details.time_zone);
            for (Id conId : contactIds) {
                Contact ct = new Contact();
                ct.Id = conId;
                ct.MailingCity = details.city;
                ct.MailingPostalCode = details.state_code;
                // ct.MailingCountryCode = details.country_code2;
                ct.MailingLatitude = Decimal.valueOf(details.latitude);
                ct.MailingLongitude = Decimal.valueOf(details.longitude);
                ct.MailingState = details.state_prov;
                ct.MailingCountry = details.country_name;
                ct.Current_User_IPV4__c = sourceIP;
                ct.Languages__c = details.languages;
                ct.MailingStreet = 'Api Not Detected Street';
                contactList.add(ct);
            }
            updateContactRecords(contactList);
            System.debug('Contact  ' + contactList);
        }
    }

    public void finish(Database.BatchableContext BC) {
        System.debug('Batch finished');
    }
    
    public static void updateContactRecords(List<Contact> wrapper) {
        System.debug('ListofContact  ' + wrapper);
        try {
            if (!wrapper.isEmpty()) {
                update wrapper;
            }
        } catch (Exception e) {
            System.debug('Error updating Contact records: ' + e.getMessage());
            // Handle the exception as needed
        }
    }
}
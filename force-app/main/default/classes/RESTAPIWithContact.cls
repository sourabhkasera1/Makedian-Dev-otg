@RestResource(urlMapping='/ContactApi/*')
global with sharing class RESTAPIWithContact {
    
    @httpPost
    global static void doPostMethod()
    { 
        system.debug('Hello ');
        RestRequest req = RestContext.request;
        system.debug('req Header'+req);
		string req1 = RestContext.request.requestBody.toString();
        system.debug('req '+ req1);
        RestResponse res = Restcontext.response;
        system.debug('res '+res);
        Map<String,Object> ids=(Map<String, Object>)JSON.deserializeUntyped(RestContext.request.requestBody.toString());//RestContext.request.params.get('id');
        system.debug('ids '+ids);
        Object contid=ids.get('id');
        system.debug('contid '+contid);
        
        //Callout To Schedaero Get Contact
        Http http = new Http();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint('https://sandbox.avinode.com/contacts/people/'+contid);
        request.setMethod('GET');
        string testing = string.valueOf(system.now());
        request.setHeader('contactid', 'contid');
        request.setHeader('X-Avinode-SentTimestamp', testing);
        request.setHeader('X-Avinode-ApiToken', '229B8C9E-B3F2-4FA6-8BAE-71DF00943C0E');
        system.debug('request  ++++++++   '+ request);
        HttpResponse response = http.send(request);
        system.debug('response  ======   '+ response);
        if(response.getStatusCode() == 200) 
        {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody()); 
            system.debug('Result ====>  '+results);            
        }else
        {
            system.debug('Faild');
        }
	}
}





/*
{
"Name":"Sourabh ",
"AnnualRevenue":"40",
"BillingCity":"Ajmer",
"Type":"Prospect"
}*/
    
    /*@httpPost
    global static Contact doPostMethod(String FirstName ,String LastName ,String Phone ,String Email){
        Contact cont= new Contact(FirstName = Firstname,LastName = Lastname, Phone = phone ,Email = email);
        insert cont;
        return cont;
	}
    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        system.debug('Req '+req);
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
        return result;
    }
     @httpDelete
    global static String doDeleteMethod(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        system.debug('Req '+req);
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account acc = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
        delete acc;
        return 'You have deleted the record succesfully!';
    }
     @httpPut
    global static Account doPutMethod(String Name, Integer AnnualRevenue, String BillingCity, String Type){
        Map<String,String> paramsMap = RestContext.request.params;
        String accid=paramsMap.get('id');
        system.debug('Account Id '+accid);
        Account acc= new Account(Id = accid,Name =name,AnnualRevenue = annualrevenue, BillingCity = billingCity ,Type = type);
        update acc;
        return acc;
    }
    */
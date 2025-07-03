({
    Addition : function(component, event, helper) {	
        var numuberOne = component.get('v.InputOne');
        var numuberTwo = component.get('v.InputTwo');
        var result = parseInt(numuberOne)+parseInt(numuberTwo);
        //alert(result);
        component.set('v.InputThree',result);
    },
    Minus : function(component, event, helper) {		
        var numuberOne = component.get('v.InputOne');
        var numuberTwo = component.get('v.InputTwo');
        var result = parseInt(numuberOne)-parseInt(numuberTwo);
        component.set('v.InputThree',result);
    },
    Multiply : function(component, event, helper) {	
        
        var numuberOne = component.get('v.InputOne');
        var numuberTwo = component.get('v.InputTwo');
        var result = parseInt(numuberOne)*parseInt(numuberTwo);
        component.set('v.InputThree',result)
    },
    Divide : function(component, event, helper) {	
        
        var numuberOne = component.get('v.InputOne');
        var numuberTwo = component.get('v.InputTwo');
        var result = parseInt(numuberOne)/parseInt(numuberTwo);
        component.set('v.InputThree',result)
    }
})
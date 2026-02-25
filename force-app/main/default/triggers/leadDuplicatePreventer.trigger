trigger leadDuplicatePreventer on Lead (before insert, before update,after undelete) {
    
    Map<String, Lead> leadMap = new Map<String, Lead>();
    
    for (Lead lead : System.Trigger.new) {
        
        if ((lead.Email != null) &&
            
            (System.Trigger.isInsert || (lead.Email != System.Trigger.oldMap.get(lead.Id).Email))) {
                
                if (leadMap.containsKey(lead.Email)) {
                    
                    lead.Email.addError('Another new lead has the ' + 'same email address.');
                    
                } else { 
                    
                    
                    leadMap.put(lead.Email, lead); 
                    
                    
                }
                
            }
        
    }
    
    for (Lead lead : [SELECT Email FROM Lead WHERE Email IN :leadMap.KeySet()]) {
        
        Lead newLead = leadMap.get(lead.Email);
        
        newLead.Email.addError('A lead with this email ' + 'address already exists.');
        
    }
    
}
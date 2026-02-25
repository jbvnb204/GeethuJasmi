trigger ContactTrigger on Contact (before insert,before update) {
    //validation rule on phone field
    for(Contact con: Trigger.new){
        if(string.isBlank(con.Phone)){
            con.Phone.addError('please add phone number');
        }
        
        if(string.isBlank(con.LeadSource)){
            con.LeadSource='web';
            
        }
    }
}
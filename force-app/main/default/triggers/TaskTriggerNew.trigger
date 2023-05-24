trigger TaskTriggerNew on Task(after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        List<Account> accList=new List<Account>();
        for(Task t:Trigger.new){
            if(t.WhatId!=null){  //WhatId is related to Id, here task is related to account
                Account acc=new Account();
                acc.Active__c='Yes';
                acc.Id=t.WhatId;
                accList.add(acc);
            }
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }


}
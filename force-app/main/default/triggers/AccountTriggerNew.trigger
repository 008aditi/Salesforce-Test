trigger AccountTriggerNew on Account (before insert,after insert) {
    //VScode
    if(Trigger.isBefore && Trigger.isInsert){
        for(Account acc: Trigger.new){
            if(acc.Active__c=='Yes'){
                acc.addError('You cannot activate the account');
            }
        }
    }
    if(Trigger.isAfter && Trigger.isInsert){ 
        List<Task> tList = new List<Task>();
        for(Account acc : trigger.new) {
        Task t = new Task();
        t.Subject = 'Review Account-'+ acc.Name;
        Date d=System.today();
        t.ActivityDate = d.addDays(7);
        t.OwnerId=acc.OwnerId;
        t.Status='Not Started';
        t.WhatId=acc.Id;
        tList.add(t);
        }
        if(!tList.isEmpty()) {
        INSERT tList;
    
        }
    }


}
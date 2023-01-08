CREATE or replace trigger hubTrigger
    After Insert or Update on input_hub
    Begin
    loadHub();
    end;
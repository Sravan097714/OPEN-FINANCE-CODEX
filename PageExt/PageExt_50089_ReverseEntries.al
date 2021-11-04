pageextension 50089 ReverseEntries extends "Reverse Entries"
{
    actions
    {
        modify(Reverse)
        {
            trigger OnbeforeAction()
            begin
                UserInput.Run();
            end;
        }
        modify("Reverse and &Print")
        {
            trigger OnbeforeAction()
            begin
                UserInput.Run();
            end;
        }
    }

    var
        UserInput: Report GLRegisterInput;
}
function [func] = input_function()
%INPUT_FUNCTION - Returns a function handle of input
%   Allows the user to input a function based off of a calculator-esque
%   input.  It will allow the user to click on buttons such as
%   ^,*,+,-,etc., and will create a string with their input.  From this
%   input, it will then use a built-in MATLAB function to convert it to a
%   function handle, and will return this function handle.
d = dialog('Position',[300 500 300 400],'Name','Input Function');

%==========================================================================
% Create buttons
% EX: btn = uicontrol('Parent',parent,'Values',...)
% EX: buttonName = uicontrol('Parent',d,'String','some_string','Position',[w x y z],'Callback',@some_func);
% would create a button object that appears at position w x y z, relative
% to the parent, d, with the string "some_string" written on it with
% callback to some_func.
% Parent - the dialog box to base positioning off of.
% Values - can range from a multitude of things (look in help feature),
% some common values are 'String', 'Position', and 'Callback'
% Callback - when the button is pressed on, perform an action.  In our case
% we want to update the user_input string every time a button is pressed.
one = uicontrol('Parent',d,'String','1','Position',[10 10 50 50],'Callback',@update_string);
two = uicontrol('Parent',d,'String','2','Position',[65 10 50 50],'Callback',@update_string);
three = uicontrol('Parent',d,'String','3','Position',[120 10 50 50],'Callback',@update_string);
four = uicontrol('Parent',d,'String','4','Position',[10 65 50 50],'Callback',@update_string);
five = uicontrol('Parent',d,'String','5','Position',[65 65 50 50],'Callback',@update_string);
six = uicontrol('Parent',d,'String','6','Position',[120 65 50 50],'Callback',@update_string);
seven = uicontrol('Parent',d,'String','7','Position',[10 120 50 50],'Callback',@update_string);
eight = uicontrol('Parent',d,'String','8','Position',[65 120 50 50],'Callback',@update_string);
nine = uicontrol('Parent',d,'String','9','Position',[120 120 50 50],'Callback',@update_string);
vari = uicontrol('Parent',d,'String','x','Position',[10 230 50 50],'Callback',@update_string);
zero = uicontrol('Parent',d,'String','0','Position',[10 175 50 50],'Callback',@update_string);
expo = uicontrol('Parent',d,'String','.^','Position',[65 175 50 50],'Callback',@update_string);
minus = uicontrol('Parent',d,'String','-','Position',[175 175 50 50],'Callback',@update_string);
add = uicontrol('Parent',d,'String','+','Position',[175 120 50 50],'Callback',@update_string);
mult = uicontrol('Parent',d,'String','.*','Position',[175 65 50 50],'Callback',@update_string);
div = uicontrol('Parent',d,'String','./','Position',[175 10 50 50],'Callback',@update_string);
del = uicontrol('Parent',d,'String','<--','Position',[230 175 50 50],'Callback',@deletechar);
leftparen = uicontrol('Parent',d,'String','(','Position',[230 120 50 50],'Callback',@update_string);
rightparen = uicontrol('Parent',d,'String',')','Position',[230 65 50 50],'Callback',@update_string);
clear = uicontrol('Parent',d,'String','CLEAR','Position',[230 10 50 50],'Callback',@deleteall);
equal = uicontrol('Parent',d,'String','=','Position',[120 175 50 50],'Callback',@finish);
user = uicontrol('Parent',d,'Style','text','String','','Position',[10 300 160 20]);
uiwait(d); % Wait for the dialog to close before moving on to the rest of the code
%==========================================================================
% Function callbacks to update the user input string when button pressed
    
    % Update user entered string
    function update_string(hObject,callbackdata)
        temp = strcat(user.String,hObject.String);
        set(user,'String',temp);
    end

    % Ends the program and sends the function to the output
    function finish(hObject,callbackdata)
        temp = strcat('(',user.String);
        temp = strcat(temp,')');
        user_input = strcat('@(x)',temp);
        delete(d);
    end

    % Delete the last character in the string
    function deletechar(hObject,callbackdata)
        temp = user.String;
        temp = temp(1:end-1)
        set(user,'String',temp)
    end

    % Delete all the characters 
    function deleteall(hObject,callbackdata)
        set(user,'String','');
    end

%==========================================================================
% Return the user input string as a function
func = str2func(user_input);
end


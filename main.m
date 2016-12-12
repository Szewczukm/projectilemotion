% Mark Szewczuk
% Main Script
% ENR 125
% This script will utilize other functions to create an animation of a
% projectile motion problem 
%============================ Part 1 ===============================
h = animatedline;  % Create the object that will be the line that we draw
f = input_function(); % Input is a script, similar to calculator, allows user 
                      % to input a function with buttons.  Returns a
                      % function handle.
zero = fzero(f,0)% insert function to return the zero of the function; 
x = linspace(0,zero,1000); % Create 1000 points between 0 and where f(x)=0
y = f(x); % Create vector of y-values for every x on the function
m = max(y)+0.1; % Find the max value in y
axis([0 zero 0 m]) % First [] will be the x-axis markings, Second [] 
                       % will be the y-axis markings
                       % X-axis will go from 0 to the first zero of the function,
                       % Y-axis will go from 0 to the max-value of the function
%======================== End of Part 1 =============================

%============================ Part 2 ================================
% This for loop goes from 1 to the length of x, which has a value for each
% function value and adds this point to the animated line object.  This
% will go through and add a point and draw that point everytime the loop is
% executed
for i = 1:length(x)
    addpoints(h,x(i),y(i)); % Add points to the animated line to draw
    drawnow % Execute the drawing
end
%======================== End of Part 2 =============================





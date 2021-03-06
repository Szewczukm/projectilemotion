% Mark Szewczuk
% GATHERTERMS - Gathers and sorts the terms of a polynomial in ascending
% order, filling in zeroes for missing terms
% Returns sorted array of highest degree coefficient 
% EX: If f = @(x)(-x.^3+3.*x^5), a call to gatherterms(f) will return
% [3 0 -1 0 0 0]
function [sortedpoly] = gatherterms(f)
    text = func2str(f); % convert a function handle to a string
    
    text = text(6:end-1); % capture only the function part itself
    pattern = '(-)?(\d*\.\*)?x(\.\^\d*)?'; % A way to search any string for certain sequences of information
                                             % Here we are looking for any number of
                                             % polynomial terms along with their
                                             % coefficients.
    [start, m_end] = regexp(text,pattern); % Grabs the starting and ending index of each term
    gt = strings([1,length(start)]); % Create a blank array of strings
    for i=1:length(start)
        gt(i)=text(start(i):m_end(i)); % Gather each term of the polynomial into an array
    end
    numterms=length(gt);
    lengthgt = length(gt);
    % if there is no x terms, meaning the input is just a constant, return
    % the constant
    if(lengthgt == 0)
        sortedpoly = [str2double(text)];
        return
    end
    
    % Find the highest degree polynomial term
    pattern = '((?<=x\.\^)\d+)|(x(?!\.\^))'; % search for any number of numbers after a .^ or an x
    degree = strings([length(gt),1]); % make an array of degrees for the amount of terms 
    [start,m_end]=regexp(text,pattern); % grab the powers on a number
    % select degree's of polynomials
    for i=1:length(start)
        degree(i) = text(start(i):m_end(i));
        if(degree(i)=='x')
            degree(i)='1';
        end
    end
    
    chardeg = char(degree); % convert string array, degree, into a char array to find highest degree
    % find highest degree
    highestdeg = 0;
    for i=1:lengthgt
        if(highestdeg<chardeg(i,1:length(chardeg(i,:))))
            highestdeg=chardeg(i,1:length(chardeg(i,:)));
        end
    end
    
    % create array of zeros of size (1,highestdeg+1)
    highestdegnum = str2double(highestdeg);
    sortedpoly = zeros(1,highestdegnum+1);
    % find coefficients of each term
    pattern = '-?\d+(?=\.\*x)|(+x)?';
    coeff = strings([length(gt),1]);
    [start, m_end] = regexp(text,pattern);
    for i=1:length(start)
        coeff(i) = text(start(i):m_end(i));
        if(strtrim(coeff(i,1))=='-')
            coeff(i)='-1';
        end
    end
    
    % if a +x is found, change it to a 1
    for i=1:length(coeff)
        if(coeff(i)=='+x')
            coeff(i)='1';
        end
    end
    
    % populate sortedpoly
    for i=1:length(chardeg)
        sortedpoly(str2num(strtrim(chardeg(i,:)))) = coeff(i);
    end
    
    % flip from left to right.  Populate sortedpoly arranges backwards?
    % (EDITORS NOTE: bad code)
    sortedpoly = fliplr(sortedpoly);
    % circular shift everything one unit to the left
    sortedpoly = circshift(sortedpoly,-1);
    
    % find constant and apply it to the last 
    pattern = '(?<=+|-)\d+';
    [start,m_end]=regexp(text,pattern);
    if(~isempty(start))
        sortedpoly(length(sortedpoly)) = str2num(text(start(1):m_end(1)));
    end
    
end

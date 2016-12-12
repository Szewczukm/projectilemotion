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
    [start, m_end] = regexp(text,pattern,'start','end'); % Grabs the starting and ending index of each term
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
    pattern = '(?<=\.\^)\d*|(?!.)x'; % search for any number of numbers after a .^ or an x
    degree = strings([length(gt),1]);
    chargt = char(gt); % convert string array, gt, into a char array to select degree
    [start,m_end]=regexp(text,pattern,'start','end')
    % select degree's of polynomials
    for i=1:lengthgt
        [start(i), m_end(i)] = regexp(chargt(i),pattern,'start','end');
        disp(start);disp(m_end);
        degree(i) = chargt(1,start(i):m_end(i),i);
        if(degree(i)=='x')
            degree(i)='1';
        end
    end
    
    chardeg = char(degree); % convert string array, degree, into a char array to find highest degree
    % find highest degree
    for i=1:lengthgt
        highestdeg = 0;
        if(highestdeg<chardeg(1,1:length(chardeg)))
            highestdeg=chardeg(1,1:length(chardeg));
        end
    end
    
    % create array of zeros of size (1,highestdeg+1)
    highestdegnum = str2double(highestdeg);
    sortedpoly = zeros(1,highestdegnum+1);
    fprintf('highestdegnum %f\n',highestdegnum);
    disp('sortedpoly');
    disp(sortedpoly);
    
    % find coefficients of each term
    pattern = '-?\d*(?=\.\*x|x)';
    coeff = strings([length(gt),1])
    disp('coeff');
    disp(coeff);
    for i=1:lengthgt
        [start(i), m_end(i)] = regexp(gt(i),pattern,'start','end');
        coeff(i) = chargt(1,start(i):m_end(i),i)
        disp(coeff(i))
        if(strtrim(coeff(i,1))=='-')
            coeff(i)='-1';
        end
    end
    
end

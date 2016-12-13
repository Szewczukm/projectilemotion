% Mark Szewczuk
% GET_FIRST_REAL - gets the real solutions of a set and sorts them from lowest
% to highest
function [firstreal] = get_first_real(unsortedall)
    sortedreals = unsortedall(~imag(unsortedall)); % get only the non-imaginary numbers
    sortedreals = sort(sortedreals); % sort the sorted real solutions in ascending order
    % go through the list of real solutions and find the first instance of
    % a value greater than 0, then return once found.
    for i=1:length(sortedreals)
        if(sortedreals(i)>0)
            firstreal = sortedreals(i);
            break;
        end
    end
end

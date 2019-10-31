function [scaled, mins, ranges] = rescale_data(data, mins_in, ranges_in)

%
% scale the elements of all the column vectors to [0,1]
%
% DATA: data matrix where each column is a feature
% MINS_IN: minimums from previously scaled data (used for scaling test data)
% RANGES_IN: ranges from previously scaled data (used for scaling test data)
%
% SCALED: scales data matrix
% MINS: minimum values (important for scaling test data)
% RANGES: range values (important for scaling test data)

if nargin < 3
    mins = min(data, [], 1);
    ranges = max(data, [], 1) - mins;
else
    mins = mins_in;
    ranges = ranges_in;
end

scaled = (data - repmat(mins,size(data,1),1))*spdiags(1./(ranges)',0,size(data,2),size(data,2));
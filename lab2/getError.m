function [ error_mat ] = getError( df, j, n_points )

%   error_mat: output error matrix
%   df: 3D matrix of discriminant functions
%   j: number of sequential discriminants
%   n_points: total number of points used to train the discriminant
%             function (used to normalize the error numbers)

error_mat = [];

for i=1:length(df)
    if(df(j,4,i) == 0)
        error_mat = [error_mat df(j,5,i)];
    else
        error_mat = [error_mat df(j,4,i)];
    end
end

error_mat = error_mat/n_points;

end


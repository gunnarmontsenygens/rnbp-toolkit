function vj_vec = Xbar2vj(X,j, N)
%==========================================================================
%
% Extracts jth barycentric velocity from Barycentric state vector X.
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
%  X  -    state vector X = [r_1;...;r_n; v_1;...;v_n] (6N x 1)         -
%  j -      index
% N - number of bodies
%
% OUTPUT:       
%  vj_vec -  jth barycentric velocity coordinate (1x3)                  -

%==========================================================================
    
    % Index computation
    idx_1 = 3*(j-1)+1+3*N;
    idx_2 = 3*j+3*N;
    
    % Formula
    vj_vec = X(idx_1:idx_2,1);
end

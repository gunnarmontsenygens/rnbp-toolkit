function rj_vec = Xbar2rj(X,j)
%==========================================================================
%
% Extracts jth barycentric coordinate from Barycentric state vector X.
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
%
% OUTPUT:       
%  rj_vec -  jth barycentric position coordinate                        -

%==========================================================================

    % Index computation
    idx_1 = 3*(j-1)+1;
    idx_2 = 3*j;
    
    % Formula
    rj_vec = X(idx_1:idx_2,1);
end

function Rj_vec = Xjac2Rj(X,j)
%==========================================================================
%
% Extracts jth Jacobi coordinate from Jacobi state vector X.
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
%  X  -    state vector X = [R_1;...;R_N-1; V_1;...;V_N-1] (6(N-1)x 1)  -
%  j -      index
%
% OUTPUT:       
%  Rj_vec -  jth Jacobi position coordinate                             -

%==========================================================================
    
    % Index computation
    idx_1 = 3*(j-1)+1;
    idx_2 = 3*j;
    
    % Formula
    Rj_vec = X(idx_1:idx_2,1);

end

function Rj_vec = r2Rj(Rcj_vec, rvec_list,j)
%==========================================================================
%
% Calculates Jacobi coordinate j from 
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
%  m_list  -    list of masses (N x 1) shape                            -
%  rvec_list -  barycentric positions (N x 3)                           -
%  j        -   index  in  {1,..., N-1}                                 -
%
% OUTPUT:       
%  Rcj_vec  -    center of mass vector of the selected j bodies          -

%==========================================================================

    % Formula
    Rj_vec = rvec_list(j+1,:) - Rcj_vec;
end

function Rcj_vec = CoMj(rvec_list,  m_list, j)
%==========================================================================
%
% Calculates center of mass of bodies from i = 1, ..., j
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
%  j        -   index                                                   -
%
% OUTPUT:       
%  Rcj_vec  -    center of mass vector of the selected j bodies         -

%==========================================================================

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);

    % Loop
    S = 0;
    
    for i = 1 : j
        S = S + m_list(i)*rvec_list(i,:);
    end
    
    % Final formula
    Rcj_vec = S/M_list(j);

end

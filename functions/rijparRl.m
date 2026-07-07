function drij_dRl = rijparRl(m_list, i, j, l)
%==========================================================================
%
% Calculates partial of r_ij wrt to Rl.
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
%  m_list  -    list of masses (N x 1) shape                            -
%  i, j, l - indices
%
% OUTPUT:       
%  drij_dRl -  partial of r_ij wrt Rl                                    -

%==========================================================================

    % Initialization
    m_list = m_list(:);
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);

    % Computation
    if l > j-1
        drij_dRl = zeros(3,3);
    elseif l == j-1
        drij_dRl = eye(3,3);
    elseif (j-2 >= l) && (l > i-1)
        drij_dRl = (m_list(l+1)/M_list(l+1))*eye(3,3);
    elseif l == i-1
        drij_dRl = -(M_list(i-1)/M_list(i))*eye(3,3);
    elseif l < i-1
        drij_dRl = zeros(3,3);
    end

end

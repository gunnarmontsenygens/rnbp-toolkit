function V_vec_list = v2V(v_vec_list, m_list)
%==========================================================================
%
% Calculates all Jacobi velocities from list of all barycentric velocities.
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
%  m_list  -    list of masses (N x 1) shape                            -
%  vvec_list -  barycentric velocities (N x 3)                           -
%
% OUTPUT:       
%  Rvec_list -  jacobi coordinate velocities (N x 3)                      -

%==========================================================================

    % Initialization
    N = length(v_vec_list(:,1));
    V_vec_list = zeros(N-1, 3);
    
    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    
    % Loop
    for j = 1 : N-1
        Vcj_vec = CoMj(v_vec_list, m_list, j);
        V_vec_list(j,:) = v_vec_list(j+1,:) - Vcj_vec;
    end
end

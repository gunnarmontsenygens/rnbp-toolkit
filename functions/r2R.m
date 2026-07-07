function Rvec_list = r2R(rvec_list, m_list)
%==========================================================================
%
% Calculates all Jacobi coordinates from list of all barycentric positions.
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
%
% OUTPUT:       
%  Rvec_list -  jacobi coordinate positions (N x 3)                      -

%==========================================================================

    % Initialization
    N = length(rvec_list(:,1));
    Rvec_list = zeros(N-1, 3);

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);
    
    % Loop
    for j = 1 : N-1
        Rcj_vec = CoMj(rvec_list,m_list, j);
        Rvec_list(j,:) = rvec_list(j+1,:) - Rcj_vec;
    end
end

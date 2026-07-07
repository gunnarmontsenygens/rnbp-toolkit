function dX_dt = f_NBP_jac(t, X, m_list)
%==========================================================================
%
% Differential equation for NBP with jacobi coordinates
% G = 1.
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
%  X  -    state vector X = [R_1;...;R_N-1; V_1;...;V_N-1] (6(N-1)x 1)  -
%  m_list  -    list of masses (N x 1) shape                            -
%
% OUTPUT:       
%  dX_dt -  time derivative of X       (6(N-1)x 1)                       -

%==========================================================================

    % Problem initialization
    X = X(:);
    m_list = m_list(:);
    dX_dt = zeros(size(X));
    N = length(m_list);

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);

    % Compute dRl_dt
    for l = 1 : 3*(N-1)
        dX_dt(l,1) = X(l+3*(N-1),1);
    end

    % Compute dVl_dt
    for l = 3*(N-1) + 1 : 3 : 6*(N-1)

        % Compute sum with l through all (i,j) pairs
        S = 0; 

        new_idx = idx_comp(l,N);

        for i = 1 : N-1
            for j = i+1 : N
                
             
                rij_vec = Xjac2rij(X, m_list, i, j)'; r_ij = norm(rij_vec);
                drij_dRl = rijparRl(m_list, i, j, new_idx);
                S = S + m_list(i)*m_list(j)*rij_vec*drij_dRl/r_ij^3; 

            end
        end

        dX_dt(l: l+2,1) = -(M_list(new_idx+1)/(M_list(new_idx)*m_list(new_idx+1)))*S;
    end

end

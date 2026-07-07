function U = U_NBP(X, m_list, input_coord)
%==========================================================================
%
% Computes potential energy from state vector X
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
%  X  -    state vector X. can be barycentric or jacobi                -
% input_ coord - 'jacobi' or 'barycentric'
%  m_list  -    list of masses (N x 1) shape                            -
%
% OUTPUT:       
% U - potential energy

%==========================================================================

    % Initialization
    U = 0;
    N = length(m_list);
    
    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);

    % State vector X in Jacobi coord 
    % X =[R_1; ... ; R_N-1 ; V_1 ; ... ; V_N-1]
    if strcmp(input_coord,'jacobi') == 1

        % Loop
        for i = 1 : N-1
            for j = i+1 : N
                rij_vec =  Xjac2rij(X, m_list, i, j); rij = norm(rij_vec);
                U = U - m_list(i)*m_list(j)/rij;
            end
        end
    end

    % State vector X in barycentric coordinate
    % X =[r_1; ... ; r_N ; v_1 ; ... ; v_n]
    if strcmp(input_coord,'barycentric') == 1

        % Loop
        for i = 1 : N-1
            for j = i +1 : N
                rij_vec =  Xbar2rj(X, j) - Xbar2rj(X, i); rij = norm(rij_vec);
                U = U - m_list(i)*m_list(j)/rij;
            end
        end
    end
end

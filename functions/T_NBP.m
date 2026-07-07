function T = T_NBP(X, m_list, input_coord)
%==========================================================================
%
% Computes kinetic energy from state vector X
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
% T - kinetic energy

%==========================================================================

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);

    % Initialization
    T = 0;
    N = length(m_list);

    % State vector X in Jacobi coord 
    % X =[R_1; ... ; R_N-1 ; V_1 ; ... ; V_N-1]
    if strcmp(input_coord,'jacobi') == 1

        % Loop
        for i = 1 : N-1
            Vi_vec = Xjac2Vj(X,i, N);
    
            T = T + 0.5*((M_list(i)*m_list(i+1))/(M_list(i+1)))*dot(Vi_vec, Vi_vec);
   
        end
    end

    % State vector X in barycentric coordinate
    % X =[r_1; ... ; r_N ; v_1 ; ... ; v_n]
    if strcmp(input_coord,'barycentric') == 1

        % Loop
        for i = 1 : N
            vi_vec = Xbar2vj(X,i, N);
            T = T + 0.5*m_list(i)*dot(vi_vec, vi_vec);
        end
    end

end

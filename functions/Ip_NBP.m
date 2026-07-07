function Ip = Ip_NBP(X, m_list, input_coord)
%==========================================================================
%
% Computes polar moment of inertia from state vector X
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
% Ip - polar moment of inertia

%==========================================================================

    % Initialization
    Ip = 0;
    N = length(m_list);

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;

    % State vector X in Jacobi coord 
    % X =[R_1; ... ; R_N-1 ; V_1 ; ... ; V_N-1]
    if strcmp(input_coord,'jacobi') == 1
        
        % Obtain barycentric distances
        ri_vec_list = Xjac2r(X, m_list);

        % Loop
        for i = 1 : N
            ri_vec = ri_vec_list(i,:); r_i = norm(ri_vec);
            Ip = Ip + m_list(i)*r_i^2;
        end
    end

    % State vector X in barycentric coordinate
    % X =[r_1; ... ; r_N ; v_1 ; ... ; v_n]
    if strcmp(input_coord,'bary') == 1

        % Loop
        for i = 1 : N
            ri_vec = Xbar2rj(X,i); r_i = norm(ri_vec);
            Ip = Ip + m_list(i)*r_i^2;
        end
    end

end

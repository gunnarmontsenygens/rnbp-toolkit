function H_vec = H_NBP(X, m_list, input_coord)
%==========================================================================
%
% Computes angular momentum vector from state vector X
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
% H_vec - angular momentum vector

%==========================================================================

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);

    if strcmp(input_coord,'jacobi') == 1

        % Initialization
        H_vec = [0,0,0]';
        N = length(m_list);
        
        % Loop
        for i = 1 : N-1
            Ri_vec = Xjac2Rj(X,i);
            Vi_vec = Xjac2Vj(X,i, N);
    
            H_vec = H_vec + ((M_list(i)*m_list(i+1))/(M_list(i+1)))*cross(Ri_vec, Vi_vec);
    
        end
    else
        H_vec = [0,0,0];
    end


end

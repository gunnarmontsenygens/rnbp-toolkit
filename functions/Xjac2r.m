function rj_vec_list = Xjac2r(X, m_list)
%==========================================================================
%
% Calculates rj_vec  barycentric vector from 
%  from Jacobi state vector X, for all j in {1, ..., N}      
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
%  rij_vec -  barycentric relative position vector                       -

%==========================================================================

    % Calculate barycentric coordinates
    S_vec = [0,0,0];
    N = length(m_list);
    rj_vec_list = zeros(N,3);
    
    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);

    % j = 1
    r1_vec = Xjac2r1(X, m_list);
    rj_vec_list(1,:) = r1_vec;

    % Loops
    for j = 2 : N

        % Extract Rj
        Rjm1_vec = Xjac2Rj(X,j-1);
        rj_vec = Rjm1_vec;

        for i = 0 : j-2
            if i == 0
                rj_vec = rj_vec + r1_vec;
            else
                Ri_vec = Xjac2Rj(X,i);
                rj_vec = rj_vec + (m_list(i+1)/M_list(i+1))*Ri_vec;
            end
        end
        
        % Update general parameters
        S_vec = S_vec + m_list(j)*rj_vec;
        rj_vec_list(j,:) = rj_vec;
    end
    
end

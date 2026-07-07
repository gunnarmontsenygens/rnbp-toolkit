function vj_vec_list = Xjac2v(X, m_list)
%==========================================================================
%
% Calculates barycentric velocity vectors from 
% Jacobi state vector X, for all j in {1, ..., N}.      
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: April 2, 2026
%
%
% INPUT:               Description                                   Units
%
%  X  -    state vector X = [R_1;...;R_N-1; V_1;...;V_N-1] (6(N-1)x 1)  -
%  m_list  -    list of masses (N x 1) shape                            -
%
% OUTPUT:       
%  vj_vec_list -  barycentric velocity vector list (N x 3)              -
%
%==========================================================================

    % Initialization
    N = length(m_list);
    vj_vec_list = zeros(N,3);

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list / M_tot;
    M_list = m2M(m_list);

    % j = 1
    v1_vec = [0,0,0]';

    for i = 1 : N-1
        Vi_vec = Xjac2Vj(X,i,N);
        v1_vec = v1_vec - (m_list(i+1)/M_list(i+1))*Vi_vec;
    end

    vj_vec_list(1,:) = v1_vec';

    % Loops
    for j = 2 : N

        Vjm1_vec = Xjac2Vj(X,j-1,N);
        vj_vec = Vjm1_vec;

        for i = 0 : j-2
            if i == 0
                vj_vec = vj_vec + v1_vec;
            else
                Vi_vec = Xjac2Vj(X,i,N);
                vj_vec = vj_vec + (m_list(i+1)/M_list(i+1))*Vi_vec;
            end
        end

        vj_vec_list(j,:) = vj_vec';
    end

end
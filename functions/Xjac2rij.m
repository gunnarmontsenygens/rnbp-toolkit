function rij_vec = Xjac2rij(X, m_list, i, j)
%==========================================================================
%
% Calculates rij_vec relative barycentric vector from 
%  from Jacobi state vector X. 
%           rij_vec = rj_vec - ri_vec      
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
%  i,j -      indices
%
% OUTPUT:       
%  rij_vec -  barycentric relative position vector                       -

%==========================================================================

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);

    if (i == 1) && (j == 2)

        rij_vec = X(1:3,1);

    elseif (i == 1 && j >2)

        Rjm1_vec = Xjac2Rj(X,j-1);
        S = 0;
        
        for k = 1 : j-2
            Rk_vec = Xjac2Rj(X,k);
            S = S + (m_list(k+1)/M_list(k+1))*Rk_vec;
        end

        rij_vec = Rjm1_vec + S;

    else
        Rjm1_vec = Xjac2Rj(X,j-1);
        Rim1_vec = Xjac2Rj(X,i-1);
        Rcjm1_vec = Xjac2Rcj(X, m_list, j-1 );
        Rcim1_vec = Xjac2Rcj(X, m_list, i-1);
        
        rij_vec = Rjm1_vec - Rim1_vec + Rcjm1_vec - Rcim1_vec;
    end

end

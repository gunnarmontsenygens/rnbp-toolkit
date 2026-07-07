function Rcj_vec = Xjac2Rcj(X, m_list, j)
%==========================================================================
%
% Extracts jth CoM from Jacobi state vector X.
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
%  X  -    state vector X = [R_1;...;R_N-1; V_1;...;V_N-1] (6(N-1)x 1)  -
%  j -      index
%  m_list  -    list of masses (N x 1) shape                            -
%
% OUTPUT:       
%  Rcj_vec -  CoM of j bodies {1,..,j}                                  -

%==========================================================================

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);

    % Loop
    S = 0;
    for i = 1 : j-1
        Ri_vec = Xjac2Rj(X,i);
        S = S + (m_list(i+1)/M_list(i+1))*Ri_vec;
    end

    Rcj_vec = S;
end

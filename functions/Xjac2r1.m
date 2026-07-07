function r1_vec = Xjac2r1(X, m_list)
%==========================================================================
%
% Extracts 1st barycentric coordinate from jacobi state vector X.
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
% Note that r1_vec = R0_vec.
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
%  r1_vec -  1st barycentric position coordinate                        -

%==========================================================================

    % Initialization
    N = length(m_list);
    r1_vec = [0,0,0]';

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list/M_tot;
    M_list = m2M(m_list);

    % Loop
    for i = 1 : N-1
        Ri_vec = Xjac2Rj(X,i);
        r1_vec = r1_vec - (m_list(i+1)/M_list(i+1))*Ri_vec;
    end
end

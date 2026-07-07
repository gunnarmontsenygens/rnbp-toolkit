function v_vec_list = Xjac_list2v_list(X_list, m_list)
%==========================================================================
%
% Calculates barycentric velocity vectors from a list of Jacobi state
% vectors, for all times.
%
% Author: G. Montseny
% Date: April 2, 2026
%
%
% INPUT:               Description                                   Units
%
%  X_list  - list of Jacobi state vectors (Nt x 6(N-1))                -
%  m_list  - list of masses (N x 1) shape                              -
%
% OUTPUT:       
%  v_vec_list - barycentric velocity history (Nt x N x 3)              -
%
%==========================================================================

    % Initialization
    N = length(m_list);
    Nt = length(X_list(:,1));
    v_vec_list = zeros(Nt, N, 3);

    % Loop
    for i = 1 : Nt
        v_vec_list(i,:,:) = Xjac2v(X_list(i,:)', m_list);
    end

end
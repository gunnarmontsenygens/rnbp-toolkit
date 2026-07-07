function M_list = m2M(m_list)
%==========================================================================
%
% Calculates sum of masses.
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
%  m_list  -    list of masses (N x 1) shape                            -
%
% OUTPUT:       
%  M_list  -    M_i = M_i-1 + m_i                                       -

%==========================================================================

    % Initialization
    m_list = m_list(:);
    N = length(m_list);
    M_list = zeros(size(m_list));

    % Formula
    M_0 = 0;
    M_list(1) = m_list(1);

    for i = 2:N

        M_list(i) = M_list(i-1)+m_list(i);

    end
end

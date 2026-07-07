function E = E_NBP(X, m_list, input_coord)
%==========================================================================
%
% Computes total energy from state vector X
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
% E - total energy

%==========================================================================

    % Calculate potential energy
    U = U_NBP(X, m_list, input_coord);

    % Calculate kinetic energy
    T = T_NBP(X, m_list, input_coord);

    % Calculate total energy
    E = U + T;
end

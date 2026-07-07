function X = rv2Xbar(r_vec_list, v_vec_list)
%==========================================================================
%
% Puts barycentric positions and velocities into X barycentric state vector.   
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
%  rvec_list -  barycentric positions (N x 3)                           -
%  vvec_list -  barycentric velocities (N x 3)                           -
%
% OUTPUT:       
%  X  -    state vector X = [r_1;...;r_n; v_1;...;v_n] (6N x 1)         -

%==========================================================================

    % Initialization
    N = length(r_vec_list(:,1));
    X = zeros(6*N,1);

    % Loop
    for i = 1 : N
        X(3*(i-1)+1: 3*i ,1) = r_vec_list(i,:)';
        X(3*(i-1)+1 + 3*N : 3*i + 3*N ,1) = v_vec_list(i,:)';
    end
end

function X = RV2Xjac(R_vec_list, V_vec_list)
%==========================================================================
%
% Converts list of Jacobi positions and velocities into Jacobi state vector X.
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: March 17, 2026
%
%
% INPUT:               Description                                   Units
%
% R_vec_list - all jacobi positions (N-1,3)                            -
% V_vec_list - all jacobi velocities (N-1,3)                           -
%
% OUTPUT:       
%  X  -    state vector X = [R_1;...;R_N-1; V_1;...;V_N-1] (6(N-1)x 1)  -

%==========================================================================

    % Initialization
    N = length(R_vec_list(:,1))+1;
    X = zeros(6*(N-1),1);

    % Loop
    for i = 1 : N-1
        X(3*(i-1)+1: 3*i ,1) = R_vec_list(i,:)';
        X(3*(i-1)+1 + 3*(N-1) : 3*i + 3*(N-1) ,1) = V_vec_list(i,:)';
    end
end

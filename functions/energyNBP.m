function E_list = energyNBP(state)
%==========================================================================
%
% Computes total energy from an N-body state struct.
% Works for either:
%   - a single state:
%         r_vec_list = (N x 3),   v_vec_list = (N x 3)
%   - a time history:
%         r_vec_list = (Nt x N x 3),   v_vec_list = (Nt x N x 3)
%
% Refer to 'Jacobi_Notation.pdf' for formulas and context.
%
% Author: G. Montseny
% Date: April 2, 2026
%
%
% INPUT:               Description                                   Units
%
%  state  -   N-body state struct with fields:                         -
%             .m_list
%             .r_vec_list
%             .v_vec_list
%             .coord_type
%
% OUTPUT:
%  E_list -   total energy                                             -
%             scalar if one state is given
%             (Nt x 1) if a list of states is given
%
%==========================================================================

    % Check required fields
    if ~isfield(state, 'm_list') || ~isfield(state, 'r_vec_list') || ...
       ~isfield(state, 'v_vec_list') || ~isfield(state, 'coord_type')
        error('state must contain fields m_list, r_vec_list, v_vec_list, and coord_type.');
    end

    % Extract state
    m_list = state.m_list(:);
    r_vec_list = state.r_vec_list;
    v_vec_list = state.v_vec_list;
    coord_type = lower(state.coord_type);

    %----------------------------------------------------------------------
    % Case 1: single state
    %----------------------------------------------------------------------
    if ndims(r_vec_list) == 2

        if strcmpi(coord_type, 'barycentric')

            X = rv2Xbar(r_vec_list, v_vec_list);

        elseif strcmpi(coord_type, 'jacobi')

            X = RV2Xjac(r_vec_list, v_vec_list);

        else
            error('state.coord_type must be either ''jacobi'' or ''barycentric''.');
        end

        U = U_NBP(X, m_list, coord_type);
        T = T_NBP(X, m_list, coord_type);

        E_list = U + T;

    %----------------------------------------------------------------------
    % Case 2: list of states over time
    %----------------------------------------------------------------------
    elseif ndims(r_vec_list) == 3

        Nt = size(r_vec_list,1);
        E_list = zeros(Nt,1);

        for k = 1:Nt

            r_k_vec_list = squeeze(r_vec_list(k,:,:));
            v_k_vec_list = squeeze(v_vec_list(k,:,:));

            if strcmpi(coord_type, 'barycentric')

                X = rv2Xbar(r_k_vec_list, v_k_vec_list);

            elseif strcmpi(coord_type, 'jacobi')

                X = RV2Xjac(r_k_vec_list, v_k_vec_list);

            else
                error('state.coord_type must be either ''jacobi'' or ''barycentric''.');
            end

            U = U_NBP(X, m_list, coord_type);
            T = T_NBP(X, m_list, coord_type);

            E_list(k) = U + T;

        end

    else
        error('state.r_vec_list must have shape (N x 3) or (Nt x N x 3).');
    end

end
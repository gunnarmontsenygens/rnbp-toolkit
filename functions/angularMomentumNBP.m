function H_vec_list = angularMomentumNBP(state)
%==========================================================================
%
% Computes angular momentum vector from an N-body state struct.
% Works for either:
%   - a single state:
%         r_vec_list = (N x 3),   v_vec_list = (N x 3)
%   - a time history:
%         r_vec_list = (Nt x N x 3),   v_vec_list = (Nt x N x 3)
%
% This function computes angular momentum using Jacobi coordinates.
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
%  H_vec_list - angular momentum vector                                -
%               (3 x 1) if one state is given
%               (Nt x 3) if a list of states is given
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

    % Mass normalization
    M_tot = sum(m_list);
    m_list = m_list / M_tot;
    M_list = m2M(m_list);
    N = length(m_list);

    %----------------------------------------------------------------------
    % Case 1: single state
    %----------------------------------------------------------------------
    if ndims(r_vec_list) == 2

        % Convert to Jacobi if needed
        if strcmpi(coord_type, 'barycentric')
            R_vec_list = r2R(r_vec_list, m_list);
            V_vec_list = v2V(v_vec_list, m_list);
        elseif strcmpi(coord_type, 'jacobi')
            R_vec_list = r_vec_list;
            V_vec_list = v_vec_list;
        else
            error('state.coord_type must be either ''jacobi'' or ''barycentric''.');
        end

        % Build Jacobi state vector
        X = RV2Xjac(R_vec_list, V_vec_list);

        % Compute angular momentum
        H_vec = [0,0,0]';

        for i = 1:N-1
            Ri_vec = Xjac2Rj(X,i);
            Vi_vec = Xjac2Vj(X,i,N);
            H_vec = H_vec + ((M_list(i)*m_list(i+1))/(M_list(i+1)))*cross(Ri_vec,Vi_vec);
        end

        H_vec_list = H_vec;

    %----------------------------------------------------------------------
    % Case 2: list of states over time
    %----------------------------------------------------------------------
    elseif ndims(r_vec_list) == 3

        Nt = size(r_vec_list,1);
        H_vec_list = zeros(Nt,3);

        for k = 1:Nt

            r_k_vec_list = squeeze(r_vec_list(k,:,:));
            v_k_vec_list = squeeze(v_vec_list(k,:,:));

            % Convert to Jacobi if needed
            if strcmpi(coord_type, 'barycentric')
                R_vec_list = r2R(r_k_vec_list, m_list);
                V_vec_list = v2V(v_k_vec_list, m_list);
            elseif strcmpi(coord_type, 'jacobi')
                R_vec_list = r_k_vec_list;
                V_vec_list = v_k_vec_list;
            else
                error('state.coord_type must be either ''jacobi'' or ''barycentric''.');
            end

            % Build Jacobi state vector
            X = RV2Xjac(R_vec_list, V_vec_list);

            % Compute angular momentum
            H_vec = [0,0,0]';

            for i = 1:N-1
                Ri_vec = Xjac2Rj(X,i);
                Vi_vec = Xjac2Vj(X,i,N);
                H_vec = H_vec + ((M_list(i)*m_list(i+1))/(M_list(i+1)))*cross(Ri_vec,Vi_vec);
            end

            H_vec_list(k,:) = H_vec';

        end

    else
        error('state.r_vec_list must have shape (N x 3) or (Nt x N x 3).');
    end

end
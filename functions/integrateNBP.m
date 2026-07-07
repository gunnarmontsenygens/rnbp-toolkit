function sol = integrateNBP(state0, t_f, RelTol, AbsTol)
%==========================================================================
%
% Integrates the N-body problem from a state struct and returns the
% solution in barycentric coordinates.
%
% Internally, integration is always performed in Jacobi coordinates using
% f_RNBP_jac. The output solution is stored in barycentric coordinates.
%
% Author: G. Montseny
% Date: April 2, 2026
%
%==========================================================================

    % Check required fields
    if ~isfield(state0, 'm_list') || ~isfield(state0, 'r_vec_list') || ...
       ~isfield(state0, 'v_vec_list') || ~isfield(state0, 'coord_type')
        error('state0 must contain fields m_list, r_vec_list, v_vec_list, and coord_type.');
    end

    % Extract state
    m_list = state0.m_list(:);
    r_vec_list = state0.r_vec_list;
    v_vec_list = state0.v_vec_list;
    coord_type = state0.coord_type;

    % Number of bodies
    N = length(m_list);

    % Build Jacobi initial condition
    if strcmpi(coord_type, 'barycentric')

        R_vec_list = r2R(r_vec_list, m_list);
        V_vec_list = v2V(v_vec_list, m_list);

    elseif strcmpi(coord_type, 'jacobi')

        R_vec_list = r_vec_list;
        V_vec_list = v_vec_list;

    else
        error('state0.coord_type must be either ''barycentric'' or ''jacobi''.');
    end

    % Build Jacobi state vector
    Xjac_0 = RV2Xjac(R_vec_list, V_vec_list);

    % Integrate
    options = odeset('RelTol', RelTol, 'AbsTol', AbsTol);

    [t_list, Xjac_list] = ode45( ...
        @(t, X) f_RNBP_jac(t, X, m_list), ...
        [0, t_f], Xjac_0, options);

    % Convert to barycentric histories
    r_hist = Xjac_list2r_list(Xjac_list, m_list);
    v_hist = Xjac_list2v_list(Xjac_list, m_list);

    % Output solution struct
    sol = struct();

    sol.m_list = m_list;
    sol.t_list = t_list;
    sol.r_vec_list = r_hist;
    sol.v_vec_list = v_hist;
    sol.coord_type = 'barycentric';

end
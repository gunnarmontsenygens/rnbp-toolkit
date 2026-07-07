function state = stateNBP(m_list, r_vec_list, v_vec_list, coord_type)
%==========================================================================
%
% Creates a standardized N-body state struct.
%
% The input can be given either in barycentric coordinates or in Jacobi
% coordinates. This function only stores the data consistently; it does not
% transform coordinates.
%
% Author: G. Montseny
% Date: April 2, 2026
%
%
% INPUT:                 Description                                Units
%
%  m_list          -   mass list (N x 1) or (1 x N)                -
%  r_vec_list      -   position list                               -
%                      barycentric: (N x 3)
%                      jacobi:      (N-1 x 3)
%  v_vec_list      -   velocity list                               -
%                      barycentric: (N x 3)
%                      jacobi:      (N-1 x 3)
%  coord_type      -   'barycentric' or 'jacobi'                   -
%
% OUTPUT:
%
%  state           -   standardized state struct                    -
%
%==========================================================================

    % Initialization
    m_list = m_list(:);
    N = length(m_list);

    % Check coord_type
    if ~strcmpi(coord_type, 'barycentric') && ~strcmpi(coord_type, 'jacobi')
        error('coord_type must be either ''barycentric'' or ''jacobi''.');
    end

    % Check sizes
    if strcmpi(coord_type, 'barycentric')

        if size(r_vec_list,1) ~= N || size(r_vec_list,2) ~= 3
            error('For barycentric input, r_vec_list must be of size (N x 3).');
        end

        if size(v_vec_list,1) ~= N || size(v_vec_list,2) ~= 3
            error('For barycentric input, v_vec_list must be of size (N x 3).');
        end

    else % jacobi

        if size(r_vec_list,1) ~= N-1 || size(r_vec_list,2) ~= 3
            error('For jacobi input, r_vec_list must be of size ((N-1) x 3).');
        end

        if size(v_vec_list,1) ~= N-1 || size(v_vec_list,2) ~= 3
            error('For jacobi input, v_vec_list must be of size ((N-1) x 3).');
        end

    end

    % Create struct
    state = struct();

    state.m_list = m_list;
    state.r_vec_list = r_vec_list;
    state.v_vec_list = v_vec_list;
    state.coord_type = lower(coord_type);

end
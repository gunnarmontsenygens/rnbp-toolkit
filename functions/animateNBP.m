function animateNBP(sol, dim_mode, AnimateStep, varargin)
%==========================================================================
%
% Animates an N-body solution struct.
%
% INPUT:
%  sol         - solution struct returned by integrateNBP
%  dim_mode    - '2D' or '3D'
%  AnimateStep - animation stride (optional, default = 20)
%
% OPTIONAL INPUTS:
%  'edges' : draw polygon edges
%  'dist'  : draw CoM-to-body distances and dotted lines
%
% Author: G. Montseny
% Date: April 2, 2026
%
%==========================================================================

    % Default AnimateStep
    if nargin < 3 || isempty(AnimateStep)
        AnimateStep = 20;
    end

    % Check required fields
    if ~isfield(sol, 'm_list') || ~isfield(sol, 't_list') || ...
       ~isfield(sol, 'r_vec_list') || ~isfield(sol, 'v_vec_list')
        error('sol must contain fields m_list, t_list, r_vec_list, and v_vec_list.');
    end

    % Dispatch
    if strcmpi(dim_mode, '2D')

        animateNBP_2D(sol.r_vec_list, sol.t_list, sol.m_list, AnimateStep, varargin{:});

    elseif strcmpi(dim_mode, '3D')

        animateNBP_3D(sol.r_vec_list, sol.t_list, sol.m_list, AnimateStep, varargin{:});

    else
        error('dim_mode must be either ''2D'' or ''3D''.');
    end

end
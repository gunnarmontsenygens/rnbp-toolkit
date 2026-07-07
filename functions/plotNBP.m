function plotNBP(sol, dim_mode, varargin)
%==========================================================================
%
% Plots a frame of an N-body solution struct.
%
% INPUT:
%  sol       - solution struct returned by integrateNBP
%  dim_mode  - '2D' or '3D'
%
% OPTIONAL INPUTS:
%  t_plot    - scalar time to plot (plots nearest available frame)
%  'edges'   - draw polygon edges
%  'dist'    - draw CoM-to-body distances and dotted lines
%
% If no time is provided, the last frame is plotted.
%
% Author: G. Montseny
% Date: April 2, 2026
%
%==========================================================================

    % Check required fields
    if ~isfield(sol, 'm_list') || ~isfield(sol, 't_list') || ...
       ~isfield(sol, 'r_vec_list') || ~isfield(sol, 'v_vec_list')
        error('sol must contain fields m_list, t_list, r_vec_list, and v_vec_list.');
    end

    % Default: plot last frame
    idx_plot = length(sol.t_list);

    % Separate numeric time input from string options
    plot_options = {};
    for k = 1:length(varargin)
        if isnumeric(varargin{k}) && isscalar(varargin{k})
            [~, idx_plot] = min(abs(sol.t_list - varargin{k}));
        else
            plot_options{end+1} = varargin{k};
        end
    end

    % Truncate history up to desired frame so existing low-level plotting
    % functions still work unchanged
    r_plot = sol.r_vec_list(1:idx_plot,:,:);
    t_plot = sol.t_list(1:idx_plot);

    % Dispatch
    if strcmpi(dim_mode, '2D')

        plotNBP_lastframe_2D(r_plot, t_plot, sol.m_list, plot_options{:});

    elseif strcmpi(dim_mode, '3D')

        plotNBP_lastframe_3D(r_plot, t_plot, sol.m_list, plot_options{:});

    else
        error('dim_mode must be either ''2D'' or ''3D''.');
    end

end
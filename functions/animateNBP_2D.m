function animateNBP_2D(r_vec_list, t_list, m_list, AnimateStep, varargin)
%==========================================================================
%
% 2D animation of an N-body system (using x,y components only) with
% barycentric coordinates.
%
% INPUTS:
%   r_vec_list  : (Nt, N, 3)
%   t_list      : time vector of length Nt
%   m_list      : mass vector of length N
%   AnimateStep : animation stride (optional, default = 20)
%
% OPTIONAL INPUTS:
%   'edges' : draw polygon edges
%   'dist'  : draw CoM-to-body distances and dotted lines
%
% Author: G. Montseny
% Date: March 17, 2026
%
%==========================================================================

    % Default behavior
    draw_edges = false;
    draw_distances = false;

    % Parse varargin
    if ~isempty(varargin)
        for k = 1:length(varargin)
            if ischar(varargin{k}) || isstring(varargin{k})
                if strcmpi(varargin{k}, 'edges')
                    draw_edges = true;
                elseif strcmpi(varargin{k}, 'dist')
                    draw_distances = true;
                end
            end
        end
    end

    % Defaults
    if nargin < 4 || isempty(AnimateStep)
        AnimateStep = 20;
    end
    t = t_list(:);

    Nt = size(r_vec_list,1);
    N  = size(r_vec_list,2);

    if size(r_vec_list,3) ~= 3
        error('r_vec_list must have shape (Nt, N, 3).');
    end

    if length(t) ~= Nt
        error('Length of t_list must match the number of time steps.');
    end

    m = m_list(:);
    if length(m) ~= N
        error('m_list must be a mass vector of length N.');
    end

    % -------------------------
    % Interpolation
    % -------------------------
    t_anim = linspace(t(1), t(end), Nt)';
    r_interp = zeros(Nt, N, 3);

    for i = 1:N
        r_interp(:,i,:) = interp1(t, squeeze(r_vec_list(:,i,:)), t_anim, 'pchip');
    end

    r_vec_list = r_interp;
    t = t_anim;
    Nt = length(t);

    % -------------------------
    % Keep only x,y
    % -------------------------
    r = r_vec_list(:,:,1:2);   % (Nt, N, 2)

    % -------------------------
    % Center of mass
    % -------------------------
    Mtot = sum(m);
    rcom = zeros(Nt,2);
    for i = 1:N
        rcom = rcom + m(i)*squeeze(r(:,i,:));
    end
    rcom = rcom/Mtot;

    % -------------------------
    % Marker sizes
    % -------------------------
    m_norm = m ./ max(m);
    markersize = max(5, 14 * sqrt(m_norm));

    % Colors
    bodyColors = lines(N);

    % Mass string
    mass_str = sprintf('Masses: [');
    for i = 1:N
        if i < N
            mass_str = [mass_str, sprintf('%.3g, ', m(i))];
        else
            mass_str = [mass_str, sprintf('%.3g', m(i))];
        end
    end
    mass_str = [mass_str, ']'];

    % -------------------------
    % Figure
    % -------------------------
    figure('Position',[100 100 900 700]);
    clf

    for k = 1:AnimateStep:Nt
        clf
        hold on

        % -------------------------
        % Dynamic axis limits up to time k
        % -------------------------
        allx_k = [reshape(r(1:k,:,1), [], 1); rcom(1:k,1)];
        ally_k = [reshape(r(1:k,:,2), [], 1); rcom(1:k,2)];

        xmin = min(allx_k); xmax = max(allx_k);
        ymin = min(ally_k); ymax = max(ally_k);

        if xmin == xmax, xmin = xmin - 1; xmax = xmax + 1; end
        if ymin == ymax, ymin = ymin - 1; ymax = ymax + 1; end

        dx = xmax - xmin;
        dy = ymax - ymin;

        xmin = xmin - 0.05*dx; xmax = xmax + 0.05*dx;
        ymin = ymin - 0.05*dy; ymax = ymax + 0.05*dy;

        h_body = gobjects(N,1);

        % Trails
        for i = 1:N
            h_body(i) = plot(squeeze(r(1:k,i,1)), squeeze(r(1:k,i,2)), ...
                'LineWidth', 1, 'Color', bodyColors(i,:));
        end

        hcomtrail = plot(rcom(1:k,1), rcom(1:k,2), 'k--', 'LineWidth', 1.5);

        rk = squeeze(r(k,:,:));   % (N,2)
        rc = rcom(k,:);

        % Bodies
        for i = 1:N
            plot(rk(i,1), rk(i,2), 'o', ...
                'MarkerSize', markersize(i), ...
                'MarkerEdgeColor', 'k', ...
                'MarkerFaceColor', bodyColors(i,:), ...
                'HandleVisibility', 'off');
        end

        % Polygon
        if draw_edges
            plot([rk(:,1); rk(1,1)], [rk(:,2); rk(1,2)], ...
                'k-', 'LineWidth', 1.5, 'HandleVisibility', 'off');
        end

        % CoM
        hcom = plot(rc(1), rc(2), 'x', ...
            'MarkerSize', 10, ...
            'LineWidth', 1.8, ...
            'Color', 'r');

        % CoM connectors and distances
        if draw_distances
            for i = 1:N
                plot([rc(1), rk(i,1)], [rc(2), rk(i,2)], '--k', ...
                    'HandleVisibility', 'off');
            end

            for i = 1:N
                ri = rk(i,:);
                d = norm(ri - rc);
                mid = 0.5*(ri + rc);

                v = ri - rc;
                nvec = [-v(2), v(1)];
                if norm(nvec) > 0
                    nvec = nvec / norm(nvec);
                end

                offset = 0.05 * max(dx,dy);
                pos = mid + offset * nvec;

                text(pos(1), pos(2), sprintf('%.2f', d), ...
                    'HorizontalAlignment', 'center', ...
                    'VerticalAlignment', 'middle', ...
                    'FontSize', 8, ...
                    'BackgroundColor', 'w', ...
                    'Margin', 1);
            end
        end

        xlabel('$x$','Interpreter','latex')
        ylabel('$y$','Interpreter','latex')
        title(sprintf('NBP Integration, $t$ = %.6g', t(k)))
        subtitle(mass_str)

        bodyLabels = arrayfun(@(i) sprintf('$\\vec{r_{%d}}(t)$', i), 1:N, 'UniformOutput', false);
        legend([h_body; hcom], ...
            [bodyLabels, {'CoM'}], ...
            'Location', 'eastoutside', 'Interpreter', 'latex')

        grid on
        box on
        axis equal
        xlim([xmin xmax])
        ylim([ymin ymax])

        drawnow limitrate
    end
end
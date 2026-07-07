function plotNBP_lastframe_3D(r_vec_list, t_list, m_list, varargin)
%==========================================================================
%
% Plots the last frame of an N-body trajectory in 3D using barycentric
% coordinates.
%
% OPTIONAL INPUTS:
%   'edges' : draw polygon edges
%   'dist'  : draw CoM-to-body distances and dotted lines
%
% Author: G. Montseny
% Date: April 2, 2026
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

    t = t_list(:);
    m = m_list(:);

    Nt = size(r_vec_list,1);
    N  = size(r_vec_list,2);

    if size(r_vec_list,3) ~= 3
        error('r_vec_list must have shape (Nt, N, 3).');
    end

    % Center of mass
    Mtot = sum(m);
    rcom = zeros(Nt,3);
    for i = 1:N
        rcom = rcom + m(i)*squeeze(r_vec_list(:,i,:));
    end
    rcom = rcom/Mtot;

    % Marker sizes
    m_norm = m ./ max(m);
    markersize = max(5, 14 * sqrt(m_norm));

    % Colors
    bodyColors = lines(N);

    % Axis extents for text offset
    allx = [reshape(r_vec_list(:,:,1), [], 1); rcom(:,1)];
    ally = [reshape(r_vec_list(:,:,2), [], 1); rcom(:,2)];
    allz = [reshape(r_vec_list(:,:,3), [], 1); rcom(:,3)];
    dx = max(allx) - min(allx);
    dy = max(ally) - min(ally);
    dz = max(allz) - min(allz);
    if dx == 0, dx = 1; end
    if dy == 0, dy = 1; end
    if dz == 0, dz = 1; end

    % Last frame
    k = Nt;
    rk = squeeze(r_vec_list(k,:,:));
    rc = rcom(k,:);

    % Figure
    figure('Position',[100 100 900 700]);
    clf
    hold on

    h_body = gobjects(N,1);

    % Trails
    for i = 1:N
        h_body(i) = plot3(squeeze(r_vec_list(1:k,i,1)), ...
                          squeeze(r_vec_list(1:k,i,2)), ...
                          squeeze(r_vec_list(1:k,i,3)), ...
                          'LineWidth', 1, 'Color', bodyColors(i,:));
    end

    hcomtrail = plot3(rcom(1:k,1), rcom(1:k,2), rcom(1:k,3), ...
        'k--', 'LineWidth', 1.5);

    % Bodies
    for i = 1:N
        plot3(rk(i,1), rk(i,2), rk(i,3), 'o', ...
            'MarkerSize', markersize(i), ...
            'MarkerEdgeColor', 'k', ...
            'MarkerFaceColor', bodyColors(i,:), ...
            'HandleVisibility', 'off');
    end

    % Polygon
    if draw_edges
        plot3([rk(:,1); rk(1,1)], [rk(:,2); rk(1,2)], [rk(:,3); rk(1,3)], ...
            'k-', 'LineWidth', 1.5, 'HandleVisibility', 'off');
    end

    % CoM
    hcom = plot3(rc(1), rc(2), rc(3), 'x', ...
        'MarkerSize', 10, ...
        'LineWidth', 1.8, ...
        'Color', 'r');

    % CoM connectors and distances
    if draw_distances
        for i = 1:N
            plot3([rc(1), rk(i,1)], [rc(2), rk(i,2)], [rc(3), rk(i,3)], '--k', ...
                'HandleVisibility', 'off');
        end

        for i = 1:N
            ri = rk(i,:);
            d = norm(ri - rc);
            mid = 0.5*(ri + rc);

            offset = 0.04 * max([dx, dy, dz]);
            pos = mid + [offset, offset, offset];

            text(pos(1), pos(2), pos(3), sprintf('%.2f', d), ...
                'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'middle', ...
                'FontSize', 8, ...
                'BackgroundColor', 'w', ...
                'Margin', 1);
        end
    end

    xlabel('$x$','Interpreter','latex')
    ylabel('$y$','Interpreter','latex')
    zlabel('$z$','Interpreter','latex')
    title(sprintf('NBP Integration, $t$ = %.6g', t(k)))

    bodyLabels = arrayfun(@(i) sprintf('$\\vec{r_{%d}}(t)$', i), 1:N, 'UniformOutput', false);
    legend([h_body; hcom], ...
        [bodyLabels, {'CoM'}], ...
        'Location', 'eastoutside', 'Interpreter', 'latex')

    grid on
    box on
    axis equal
    view(3)

end
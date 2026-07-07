function r_vec_list = Xjac_list2r_list(X_list, m_list)

    % Initialization
    N = length(m_list);
    Nt = length(X_list(:,1));
    r_vec_list = zeros(Nt, N, 3);

    % Loop
    for i = 1 : Nt
        r_vec_list(i, :, :) = Xjac2r(X_list(i,:)', m_list);
    end

end

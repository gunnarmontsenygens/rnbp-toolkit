function new_idx = idx_comp(old_idx, N)
% Helper function for indexing of X jacobi state vector.
    new_idx = ceil((old_idx - 3*(N-1))/3);
end

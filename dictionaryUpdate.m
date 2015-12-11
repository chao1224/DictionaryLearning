function d = dictionaryUpdate(d, A, B)
    [m, k] = size(d);
    neo_d = zeros(m,k);
    
    for times = 1 : 100
       for j = 1 : k
          u = d(:,j) + ( B(:,j) - d * A(:,j) ) / A(j,j);
          ttt = 1.0 / max( norm(u,2) , 1 );
          %disp(sprintf('%.10f %.10f',ttt, A(j,j)));
          neo_d(:,j) = ttt * u;
       end
       
       %disp(sprintf('%.10f, %.10f %.10f',pre, current, delta));
       
       d = neo_d;
    end
end
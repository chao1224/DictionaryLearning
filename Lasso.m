function [ w2 ] = Lasso( D, xt, tau, diff, lambda, w0)

w2 = w0;
w1 = w0-5;
count = 0;
while (norm(w2-w1) > diff)
    w1 = w2;
    v = tau*D'*(xt-D*w1);
    z = w1 + v;
    for i = 1:length(w2)
        w2(i) = sign(z(i))*max(0, abs(z(i))-tau*lambda/2);
    end
    %count = count + 1
    %norm(w2-w1)
end
end


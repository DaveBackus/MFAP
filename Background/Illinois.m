%Illinois Method

clear
clc

disp('Illinois Method');

MaxIterations = 50;
Tolerance = 1.e-10;
syms x

%Input Parameters
x0 = -1
x1 = 1
f = sin(x^2)+1.02-exp(-x);


fx0 = subs(f,x,x0);
fx1 = subs(f,x,x1);

if fx0 == 0
    root = x0;
elseif fx1 ==0
    root = x1;
elseif fx0*fx1 > 0 
    disp('Complex Root')
else
    for i = 1:MaxIterations
        x2 = x1 - fx1*(x1 - x0)/(fx1 - fx0);
        fx2 = subs(f,x,x2);
        if max(abs(x2 - x1),abs(fx2)) < Tolerance
            break, i
        end

        if fx1*fx2 < 0;
            x0 = x1;
            x1 = x2;
            fx0 = fx1;
            fx1 = fx2;
            %These next few lines make sure an x calculated from a secant
            %step is not actually the root (ie, the first secant step for
            %the function x^3 on the interval (-1,1) is 0, the root).
        elseif fx1 == 0
            x2 = x1, break, i
        elseif fx2 == 0
            break, i
        else
            fx_new = fx2;
% If x(n) and x(n+1) are not the same sign, it runs this loop until it
% finds a point with a sign change. x_new is the intersction of a line
% between x(n-1) and x(n+1) and the y axis. 
            while fx1*fx_new > 0
                fx0 = fx0/2;
                m = (fx2 - fx0)/(x2-x0);
                b = fx2-(m*x2);
                x_new = -b/m;
                fx_new = subs(f,x,x_new);
            end

            x0 = x2;
            x1 = x_new;
            fx0 = fx2;
            fx1 = fx_new;
        end
    end
end

root = x2
fx2
i
%  ccf_test.m 
%  Test example for ccf function 
format compact 

x = [1,3,-2,4]';
y = [3,1,4,6]';

rho = ccf(x,y,2)

return 

% Answer 
% rho =
%     0.2118
%    -0.4085
%     0.0605
%     0.5598
%    -0.2724

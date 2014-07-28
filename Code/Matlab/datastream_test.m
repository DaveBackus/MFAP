%  datastream_test.m 
%  Written by:  Dave Backus, February 2012 
format compact 
clear all 

%disp(' ')
disp('------------------------------------------------------------------')
disp('Datastream') 

C = datastream('DS:XNYU901','PICKLE','Datastream',...
               'http://dataworks.thomson.com/Dataworks/Enterprise/1.0')

return

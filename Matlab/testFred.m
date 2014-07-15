clear;
display('cleared....................');

%%download and plot GNP  
series_id='GNPCA';
[yy desc]=getFredData(series_id);

figure1 = figure('Color',[1 1 1]); 
plot(yy(:,1),yy(:,2),'r','LineWidth', 1.5);
ylabel(desc.units);
title(desc.title);
datetick('x','mm-yyyy','keepticks');
%saveas(figure1,'fig1.eps');

%download and plot the current account balance 
series_id='NETFI';
[yy desc]=getFredData(series_id);

figure2 = figure('Color',[1 1 1]);
plot(yy(:,1),yy(:,2),'b','LineWidth', 1.5);
ylabel(desc.units);
title(desc.title);
datetick('x','yyyy','keepticks');
%saveas(figure2,'fig2.eps');

display('Done.');



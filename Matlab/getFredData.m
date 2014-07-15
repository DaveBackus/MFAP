function [data_out desc] = getFredData(series_id)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Connects to FRED database and retrieves the data series identified by
%series_id.  Returns: 
%   data_out:   Nx2 matrix whose first column is dates in (serial
%               format) and second column is the data values
%   desc:       A structure with descriptive parameters: 
%               'title'
%               'freq'
%               'units'
%               'seas'    (seasonal adjustment)
%               'first'   (date of first observation)
%               'last'    (date of last observation)

%August 17, 2010
%Kim J. Ruhl kruhl@stern.nyu.edu

%This product uses the FRED® API but is not endorsed or certified by 
%the Federal Reserve Bank of St. Louis.  The terms of use can be found at
%http://api.stlouisfed.org/terms_of_use.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     

api_key='055ba538c874e5974ee22d786f27fdda';

xDoc1=xmlread(['http://api.stlouisfed.org/fred/series?series_id=',series_id,'&api_key=',api_key]);
info=xDoc1.getElementsByTagName('series');

d=struct('title',[],'freq',[],'units', [],'seas', [],'first',[],'last',[]);
desc.title=cellstr(char(getValue(info,'title')));
desc.freq=cellstr(char(getValue(info,'frequency')));
desc.units=cellstr(char(getValue(info,'units')));
desc.seas=cellstr(char(getValue(info,'seasonal_adjustment')));
desc.first=cellstr(char(getValue(info,'observation_start')));
desc.last=cellstr(char(getValue(info,'observation_end')));

xDoc=xmlread(['http://api.stlouisfed.org/fred/series/observations?series_id=',series_id,'&api_key=',api_key]);
%grab all of the observations
data=xDoc.getElementsByTagName('observation');
nn=data.getLength;
data_out=zeros(nn,2);

%An observation contains 4 attributes: realtime_start, realtime_end, date,
%and value.  It's not clear the attributes are always in the same order, so
%this bit of code finds the indices that correspond to the date and value
value_idx= getIndex(data,'value');
date_idx= getIndex(data,'date');

%read the data into a matrix
for i=0:nn-1;
data_out(i+1,1)=datenum(char(data.item(i).getAttributes.item(date_idx).getValue), 'yyyy-mm-dd');
data_out(i+1,2)=str2num(data.item(i).getAttributes.item(value_idx).getValue);
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [idx] = getIndex(dd, pattern)

n_att = dd.item(0).getAttributes.getLength;

for j=0:n_att-1
    name=dd.item(0).getAttributes.item(j).getName;
    if( strcmp(char(name),pattern) )
        idx=j;
    end
end

end %getIndex

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [val] = getValue(dd, pattern)

n_att = dd.item(0).getAttributes.getLength;

for j=0:n_att-1
    name=dd.item(0).getAttributes.item(j).getName;
    if( strcmp(char(name),pattern) )
        val=dd.item(0).getAttributes.item(j).getValue;
    end
end

end %getValue 

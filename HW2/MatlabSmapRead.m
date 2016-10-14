function data = MatlabSmapRead(archiverUrl,query,start,endtime)
% Given archiverUrl, obtain data for the given query from start to endtime.

js = JavaSmap(archiverUrl);

% Results from query
result = js.data(query, start, endtime, int64(1000));

% Confirm
% java.lang.System.out.println(result)

% Translation from JSONArray to Matlab struct
data = loadjson(char(result.toString()));

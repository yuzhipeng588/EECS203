function PSTmatlabRep = UTCtoPST(UTCjavaRep)
% Convert UTC time in Java (milliseconds since 00:00:00 UTC Jan 1, 1970) to
% Matlab serial date in PST.
PSTmatlabRep = UTCjavaRep/(86400*1000) - 8/24 + datenum(1970,1,1);
% Attribution: Sarah Koehler, skoehler@berkeley.edu

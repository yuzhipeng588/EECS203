function PDTmatlabRep = UTCtoPDT(UTCjavaRep)
% Convert UTC time in Java (milliseconds since 00:00:00 UTC Jan 1, 1970) to
% Matlab serial date in PDT.
PDTmatlabRep = UTCjavaRep/(86400*1000) - 7/24 + datenum(1970,1,1);
% Attribution: Sarah Koehler, skoehler@berkeley.edu

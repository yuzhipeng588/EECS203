function UTCjavaRep = PDTtoUTC(PDTmatlabRep)
% Convert Matlab serial date in PDT to UTC time in Java (milliseconds since
% 00:00:00 UTC Jan 1, 1970).
UTCjavaRep = (PDTmatlabRep - datenum(1970,1,1) + 7/24)*(86400*1000);
% Attribution: Sarah Koehler, skoehler@berkeley.edu


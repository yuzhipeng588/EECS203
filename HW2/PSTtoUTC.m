function UTCjavaRep = PSTtoUTC(PSTmatlabRep)
% Convert Matlab serial date in PST to UTC time in Java (milliseconds since
% 00:00:00 UTC Jan 1, 1970).
UTCjavaRep = (PSTmatlabRep - datenum(1970,1,1) + 8/24)*(86400*1000);
% Attribution: Sarah Koehler, skoehler@berkeley.edu


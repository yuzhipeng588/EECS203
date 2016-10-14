%% Dates and Times in Matlab and Java
% Fall 2016, UC Berkeley, ME C231A and EECS C220B

%% How does Matlab represent dates and times?
% The command |datenum| converts a date vector into a single number, called
% the *serial date*.  As a reference, the serial date 1 corresponds to the
% date Jan-1-0000.  As described in the |datenum| documentation, _the year
% 0000 is merely a reference point and is not intended to be interpreted as
% a real year_.
format compact

%% datenum(Year, month, day)
% This returns an integer (class in |double|), again with Jan-1-0000
% returning 1.
datenum(0,1,1)
%%
class(datenum(0,1,1))
%%
% Advancing to Feb-1-0000 should give 31+1 = 32
datenum(0,2,1)
%%
% Advancing to March-1-0000 should give 31 + 29 + 1 = 61, since February in
% the year 0000 would be a 29-day month.
%%
datenum(0,3,1)
%%
% Advancing to March-1-0001 should give 61 + 365 = 426.
datenum(1,3,1)
%%
% By this counting scheme, September 6, 2016 is day 736,579. 
datenum(2016, 9, 6)

%% datenum(Year, month, day, hour, minute, second)
% For nonzero |hour|, or |minute| or |second|, this will return a
% non-integer value, representing the fraction of the day past midnight.
% So, at noon on Jan-1-0000, it returns 1.5
datenum(0,1,1,12,0,0)
%%
% 6 hours later, at 6:00PM, give 1.75
datenum(0,1,1,18,0,0)
%%
% |datenum| also accepts a 1-by-6 array (instead of 6 arguments).  The
% command |clock| returns the current time (as set by your computer's
% clock) in the [Year Month Day Hour Minute Second] format.
clock
%%
% Convert current time to the date-number,
datenum(clock)
%%
% Note that |datenum| and |clock| are not referenced to any standard time
% zone.  These are just a reflection of what the computer's clock says,
% relative to Jan 1, 0000.  If two computers are the same room, one set to
% Eastern time (eg., NYC) and one set to Pacific time (ie. so the
% computers' clocks are 3 hours apart) both run |datenum(clock)| at the
% same instant, their answers will differ by 0.125 (1/8th of a day).

%% How does JAVA represent dates and times?
% JAVA uses millseconds since 00:00:00 UTC on January 1, 1970.  Note it is
% referenced to UTC.  UTC is 8 hours ahead of Pacific time (7 hours during
% daylight savings time).  The command
% |java.lang.System.currentTimeMillis()| returns the number of milliseconds
% since 00:00:00 UTC on January 1, 1970.  I am not sure how Java knows what
% time zone I am in, to interpret my computer's clock correctly, but
% somewhere that is available from the operating system.
cJ = java.lang.System.currentTimeMillis();
%%
% It also returns a |double|
class(cJ)

%% Converting from one (Matlab, PDT) to another (Java, UTC)
% Suppose we take the current time with Matlab (|clock|) and convert it to
% a serial date (with |datenum|).  In order to compare to the Java return
% value, we only want to account for time since the beginning of the day on
% January 1, 1970, so we should subtract off |datenum(1970,1,1)|.  Then
% since UTC is 7 hours ahead of PDT, we should add 7/24.  Finally, convert
% this to milliseconds, multiplying by 1000*60*60*24 (the number of
% millseconds in a day).  This number should agree (quite closely - at most
% a few milliseconds apart, in the 1-trillion millseconds since January
% 1970) with the result from |java.lang.System.currentTimeMillis()|.
cM = ((datenum(clock)-datenum(1970,1,1))+7/24)*1000*60*60*24;
cJ = java.lang.System.currentTimeMillis();
[cM cJ cJ-cM]
%%
% Note, this is not to say the clock on the computer is accurate in any
% sense.  It merely says that the manner in which Java and Matlab are
% accessing it, and returning some documented representation of it are in
% agreement.  This conversion (and its inverse) are implemented in the
% |PDTtoUTC| and |UTCtoPDT|
type PDTtoUTC
%%
type UTCtoPDT
%%
% Obviously, there is simple code for Pacific Standard time (PST) to UTC
% conversions.
type PSTtoUTC
%%
type UTCtoPST

%% Attribution
% UC Berkeley, Fall 2016.  Used in ME C231A and EECS C220B for reference.
% Relevant when extracting building data from |sMAP|.



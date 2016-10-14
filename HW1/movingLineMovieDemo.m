%% Demo of recording a moving-line Movie
% This is a simple script to demonstrate some of the ideas to capturing a
% sequence of "frames", collecting them into an array, and finally viewing
% them sequentially as a movie, at a fixed, specified frame rate.

%%
clf
% Initial center and orientation of line (uncaptured - see below)
%cx = 1; cy = 1; theta = 0; L = 0.5;
cx = 1; cy = 1; theta = 0; L = 5;
% Create initial line object (xdata, and ydata)
Lh = line([cx-L/2*cos(theta) cx+L/2*cos(theta)],...
    [cy-L/2*sin(theta) cy+L/2*sin(theta)]);
%+++
initState=[0 0 0 0];
TS=0.1;
[xE, yE, vE, psiE] = bikeFEsim(a, deltaF, initState, TS);
nFrames = length(xE);
%+++
%nFrames = 400;
% Allocate a 1-by-nFrames STRUCT array with 2 fields
F(nFrames) = struct('cdata',[],'colormap',[]);
disp('Creating and recording frames...')
for j = 1:nFrames
    % Change center and angle, in a sensible manner, based on Frame#
    %+++
    cx=xE(j);
    cy=yE(j);
    theta=psiE(j);
    %+++
    %cx = cos(j/nFrames*pi);
    %cy = sin(j/nFrames*pi);
    %theta = 3*pi*j/nFrames;
    % Move the line to new location/orientation
    set(Lh,'xdata',[cx-L/2*cos(theta) cx+L/2*cos(theta)],...
        'ydata', [cy-L/2*sin(theta) cy+L/2*sin(theta)]);
    % Make sure the axis stays fixed (and square)
    axis([0 500 -6 8]); axis square
    % Flush the graphics buffer to ensure the line is moved on screen
    drawnow
    % Capture frame
    F(j) = getframe;
end
disp('Playing movie...')
Fps = 100;
nPlay = 1;
movie(F,nPlay,Fps)

%% Attribution
% ME C231A and EECS C220B, Fall 2016

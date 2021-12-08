% ***************************************
% Author: Edward, lichuang52001@gmail.com
% Purpose: Calibration of AFM lateral force, using magnetic levitation
% method, experiment device: NT-MDT AFM
% Reference: Q. Li, K.-S. Kim, A. Rydberg, Review of Scientific Instruments. 77, 065105 (2006).
% ***************************************

clc
clear

%% input

filename1 = '2020.10_1B LF_2.txt' ;    % lateral force (forward) data
filename2 = '2020.10_1F LF_1.txt' ;    % lateral force (backward) data

scan_size = 40 ;                       % AFM tip scan size, unit: um

% choose data
cut_left = 51 ;
cut_right = 200 ;

%% Data Processing

LFB = textread(filename1);
LFF = textread(filename2);

Points=size(LFF,2);  
Dis=scan_size;
interval=Dis/(Points-1);
DIS=0:interval:Dis;

n=size(LFF,1);

% transfer signal unit, nA(raw data) to pA
N_LFF=1000*LFF(:,cut_left:cut_right);
N_LFB=1000*LFB(:,cut_left:cut_right);
N_DIS=DIS(:,cut_left:cut_right);


slope_LFF=[];
slope_LFB=[];
for i=2:n-2
	slope_LFF=[slope_LFF;polyfit(N_DIS,N_LFF(i,:),1)];
	slope_LFB=[slope_LFB;polyfit(N_DIS,N_LFB(i,:),1)];
end

slope_F=mean(slope_LFF,1); 
slope_B=mean(slope_LFB,1); 
slope = (slope_F(1,1)+slope_B(1,1))/2 ;  % unit: pA/um

%% output
output =['the lateral force coefficient = ',num2str(slope),' pA/um'] ;
disp(output)

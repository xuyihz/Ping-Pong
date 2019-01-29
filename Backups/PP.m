%% Generate MGT file
% main M file
% 
% Xu Yi, 2018

%%
close all; clear; clc;

%% 
fileID = fopen('Ping-Pong.mgt','w');   % Open or create new file for writing. Discard existing contents, if any.
% addpath(genpath('coor_fun'))    % 搜索路径中加入coor_fun文件夹及其下所有文件夹

%% append initial conditions
PP_init(fileID);

%% append model file
PP_model(fileID);

%%
fprintf(fileID,'*ENDDATA');

%%
fclose('all');

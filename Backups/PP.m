%% Generate MGT file
% main M file
% 
% Xu Yi, 2018

%%
close all; clear; clc;

%% 
fileID = fopen('Ping-Pong.mgt','w');   % Open or create new file for writing. Discard existing contents, if any.
% addpath(genpath('coor_fun'))    % ����·���м���coor_fun�ļ��м����������ļ���

%% append initial conditions
PP_init(fileID);

%% append model file
PP_model(fileID);

%%
fprintf(fileID,'*ENDDATA');

%%
fclose('all');

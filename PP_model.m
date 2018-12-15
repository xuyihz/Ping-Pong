%% function
% MGT model
%
% Xu Yi, 2018

%%
function PP_model(fileID)
%% initials
iNO = 0;    % �ڵ�ų�ʼ��
iEL = 0;    % ��Ԫ�ų�ʼ��
% initial conditions
Stadium_R = 26300; % �����ݰ뾶 26300, 32600, 43400, 55200.
Stadium_angle = pi; % б������ռ�����ݵĽǶ�

% ����ͼ�ϵĶ�λ [����Z��] / ������ͼ�����µ�Ϊ[0,0] / Բ����Բ�����µ�Ϊ�����ʱ�� /
Lower_Sp = [0,0]; % lower arc % start point % ���µ�����
LowerInner_Sp = [-1000,0]; % lower inner arc
Upper_Sp = [9858, 32852]; % upper arc % ���ϵ�����
UpperInner_Sp = [9858, 32852]; % upper inner arc

Lower_R = 16063; % lower arc % radius
LowerInner_R = 13964; % lower inner arc
Upper_R = 54229; % upper arc
UpperInner_R = 51067; % upper inner arc

Lower_angle_origin = 25.04 /180*pi; % lower arc % origin angle x R x start point -> CoC
Lower_angle = 47.52 /180*pi; % lower arc % angle -> end point
LowerInner_angle_origin = 26.16 /180*pi; % lower inner arc
LowerInner_angle = 52.30 /180*pi; % lower inner arc
Upper_angle_origin = 66.11 /180*pi; % upper arc
Upper_angle = 22.37 /180*pi; % upper arc
UpperInner_angle_origin = 71.02 /180*pi; % upper arc
UpperInner_angle = 23.37 /180*pi; % upper arc

% б���������� % ���������6000, ���߶�2500.
Diamond_h_max = 2500;
Diamond_b_max = 6000;

Lower_CoC = [ Lower_Sp(1) - sin(Lower_angle_origin)*Lower_R ,...
    Lower_Sp(2) + cos(Lower_angle_origin)*Lower_R]; % lower arc % centre of a circle % �����µ�Ϊ�ο�0��
LowerInner_CoC = [ LowerInner_Sp(1) - sin(LowerInner_angle_origin)*LowerInner_R ,...
    LowerInner_Sp(2) + cos(LowerInner_angle_origin)*LowerInner_R]; % lower inner arc
Upper_CoC = [ Upper_Sp(1) - sin(Upper_angle_origin)*Upper_R ,...
    Upper_Sp(2) - cos(Upper_angle_origin)*Upper_R]; % upper arc
UpperInner_CoC = [ UpperInner_Sp(1) - sin(UpperInner_angle_origin)*UpperInner_R ,...
    UpperInner_Sp(2) - cos(UpperInner_angle_origin)*UpperInner_R]; % upper inner arc
Lower_Ep = [ Lower_CoC(1) + sin(Lower_angle_origin + Lower_angle)*Lower_R ,...
    Lower_CoC(2) - cos(Lower_angle_origin + Lower_angle)*Lower_R]; % lower arc % end point % �в�
LowerInner_Ep = [ LowerInner_CoC(1) + sin(LowerInner_angle_origin + LowerInner_angle)*LowerInner_R ,...
    LowerInner_CoC(2) - cos(LowerInner_angle_origin + LowerInner_angle)*LowerInner_R]; % lower inner arc
Upper_Ep = [ Upper_CoC(1) + sin(Upper_angle_origin + Upper_angle)*Upper_R ,...
    Upper_CoC(2) + cos(Upper_angle_origin + Upper_angle)*Upper_R]; % upper arc
UpperInner_Ep = [ UpperInner_CoC(1) + sin(UpperInner_angle_origin + UpperInner_angle)*UpperInner_R ,...
    UpperInner_CoC(2) + cos(UpperInner_angle_origin + UpperInner_angle)*UpperInner_R]; % upper arc

Lower_arcL = Lower_R * Lower_angle; % lower arc % arc length
Upper_arcL = Upper_R * Upper_angle; % upper arc

% �ϡ��»������θ߶ȸ���ͳһ / ���ο���������ݰ뾶����λ��ȷ��
% �������½������
Lower_arc_num = ceil(Lower_arcL / Diamond_h_max); % �»��ֶ��� % ceil   Round towards plus infinity.
Upper_arc_num = ceil(Upper_arcL / Diamond_h_max);
Stadium_arcL_max = (Upper_Ep(1) + Stadium_R) * Stadium_angle;
Stadium_arc_num = ceil(Stadium_arcL_max / Diamond_b_max);
% Diamond_h_Lower = Lower_arcL / Lower_arc_num;
% Diamond_h_Upper = Upper_arcL / Upper_arc_num;
% Diamond_b = Stadium_arcL_max / ceil(Stadium_arcL_max / Diamond_b_max);

% �ڵ���
FZ = -6; % �ڵ��� -6kN

%% append models
fprintf(fileID,'; LowerOuter\n'); iNO_LowerOuter_init = iNO;
[iNO, iEL] = PP_model_LowerOuter(fileID, iNO, iEL, Lower_arc_num, Lower_angle, Lower_angle_origin, Lower_CoC, Lower_R, Lower_Sp, Stadium_R, Stadium_arc_num, Stadium_angle, FZ);
iNO_LowerOuter_end = iNO;
fprintf(fileID,'; LowerInner\n'); iNO_LowerInner_init = iNO;
[iNO, iEL] = PP_model_LowerInner(fileID, iNO, iEL, Lower_arc_num, LowerInner_angle, LowerInner_angle_origin, LowerInner_CoC, LowerInner_R, LowerInner_Sp, Stadium_R, Stadium_arc_num, Stadium_angle, FZ);
iNO_LowerInner_end = iNO;
fprintf(fileID,'; UpperOuter\n'); iNO_UpperOuter_init = iNO;
[iNO, iEL] = PP_model_UpperOuter(fileID, iNO, iEL, Upper_arc_num, Upper_angle, Upper_angle_origin, Upper_CoC, Upper_R, Upper_Ep, Stadium_R, Stadium_arc_num, Stadium_angle, FZ);
iNO_UpperOuter_end = iNO;
fprintf(fileID,'; UpperInner\n'); iNO_UpperInner_init = iNO;
[iNO, iEL] = PP_model_UpperInner(fileID, iNO, iEL, Upper_arc_num, UpperInner_angle, UpperInner_angle_origin, UpperInner_CoC, UpperInner_R, UpperInner_Ep, Stadium_R, Stadium_arc_num, Stadium_angle, FZ, iNO_UpperOuter_end);
iNO_UpperInner_end = iNO;
iEL = PP_model_Center(fileID, iNO, iEL, Stadium_arc_num,...
    iNO_LowerOuter_init, iNO_LowerOuter_end,...
    iNO_LowerInner_init, iNO_LowerInner_end,...
    iNO_UpperOuter_init, iNO_UpperOuter_end,...
    iNO_UpperInner_init, iNO_UpperInner_end...
    );
iEL = PP_model_bracing(fileID, iNO, iEL, Stadium_arc_num,...
    iNO_LowerOuter_init, iNO_LowerOuter_end,...
    iNO_LowerInner_init, iNO_LowerInner_end,...
    iNO_UpperOuter_init, iNO_UpperOuter_end,...
    iNO_UpperInner_init, iNO_UpperInner_end...
    );

%%
fprintf(fileID,'\n');

end
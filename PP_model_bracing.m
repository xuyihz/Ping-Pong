%% function
% MGT bracing model (Lower & Upper)
%
% Xu Yi, 2018

%%
function iEL_end = PP_model_bracing(fileID, iNO, iEL, Stadium_arc_num,...
    iNO_LowerOuter_init, iNO_LowerOuter_end,...
    iNO_LowerInner_init, iNO_LowerInner_end,...
    iNO_UpperOuter_init, iNO_UpperOuter_end,...
    iNO_UpperInner_init, iNO_UpperInner_end...
    )
%% ELEMENT(frame) diamonds
fprintf(fileID,'*ELEMENT    ; Elements\n');
fprintf(fileID,'; iEL, TYPE, iMAT, iPRO, iN1, iN2, ANGLE, iSUB, EXVAL, iOPT(EXVAL2) ; Frame  Element\n; iEL, TYPE, iMAT, iPRO, iN1, iN2, ANGLE, iSUB, EXVAL, EXVAL2, bLMT ; Comp/Tens Truss\n; iEL, TYPE, iMAT, iPRO, iN1, iN2, iN3, iN4, iSUB, iWID , LCAXIS    ; Planar Element\n; iEL, TYPE, iMAT, iPRO, iN1, iN2, iN3, iN4, iN5, iN6, iN7, iN8     ; Solid  Element\n');
ELE_TYPE = 'BEAM'; ELE_iMAT = 1; ELE_ANGLE = 0; ELE_iSUB = 0;  % iMAT = 1���ϸֽṹQ345

fprintf(fileID,'; �²������ �˼�\n');
ELE_iPRO = 4;
iNO_Outer = iNO_LowerOuter_init;
iNO_Inner = iNO_LowerInner_init;
for i = 1:iNO_LowerOuter_end-iNO_LowerOuter_init
    iN1 = iNO_Outer+i; % ���ڵ�
    iN2 = iNO_Inner+i; % �ڲ��Ӧλ�õĽڵ�
    iEL = iEL+1;
    fprintf(fileID,'   %d, %s, %d, %d, %d, %d, %d, %d\n',...
        iEL, ELE_TYPE, ELE_iMAT, ELE_iPRO,...
        iN1, iN2,...    % б����������˫�����Ӧ�������ڵ��
        ELE_ANGLE, ELE_iSUB);
end

fprintf(fileID,'; �ϲ������ �˼�\n');
ELE_iPRO = 4;
iNO_Outer = iNO_UpperOuter_init;
iNO_Inner = iNO_UpperInner_init;
for i = 1:(iNO_UpperOuter_end-iNO_UpperOuter_init-Stadium_arc_num-1) % ���ϲ�ͬ
    iN1 = iNO_Outer+i; % ���ڵ�
    iN2 = iNO_Inner+i; % �ڲ��Ӧλ�õĽڵ�
    iEL = iEL+1;
    fprintf(fileID,'   %d, %s, %d, %d, %d, %d, %d, %d\n',...
        iEL, ELE_TYPE, ELE_iMAT, ELE_iPRO,...
        iN1, iN2,...    % б����������˫�����Ӧ�������ڵ��
        ELE_ANGLE, ELE_iSUB);
end

iEL_end = iEL;
fprintf(fileID,'\n');

end
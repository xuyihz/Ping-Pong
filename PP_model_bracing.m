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
ELE_TYPE = 'BEAM'; ELE_iMAT = 1; ELE_ANGLE = 0; ELE_iSUB = 0;  % iMAT = 1材料钢结构Q345

fprintf(fileID,'; 下层网格间 杆件\n');
ELE_iPRO = 4;
iNO_Outer = iNO_LowerOuter_init;
iNO_Inner = iNO_LowerInner_init;
for i = 1:iNO_LowerOuter_end-iNO_LowerOuter_init
    iN1 = iNO_Outer+i; % 外层节点
    iN2 = iNO_Inner+i; % 内层对应位置的节点
    iEL = iEL+1;
    fprintf(fileID,'   %d, %s, %d, %d, %d, %d, %d, %d\n',...
        iEL, ELE_TYPE, ELE_iMAT, ELE_iPRO,...
        iN1, iN2,...    % 斜交网格内外双层相对应的两个节点号
        ELE_ANGLE, ELE_iSUB);
end

fprintf(fileID,'; 上层网格间 杆件\n');
ELE_iPRO = 4;
iNO_Outer = iNO_UpperOuter_init;
iNO_Inner = iNO_UpperInner_init;
for i = 1:(iNO_UpperOuter_end-iNO_UpperOuter_init-Stadium_arc_num-1) % 与上不同
    iN1 = iNO_Outer+i; % 外层节点
    iN2 = iNO_Inner+i; % 内层对应位置的节点
    iEL = iEL+1;
    fprintf(fileID,'   %d, %s, %d, %d, %d, %d, %d, %d\n',...
        iEL, ELE_TYPE, ELE_iMAT, ELE_iPRO,...
        iN1, iN2,...    % 斜交网格内外双层相对应的两个节点号
        ELE_ANGLE, ELE_iSUB);
end

iEL_end = iEL;
fprintf(fileID,'\n');

end
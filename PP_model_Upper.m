%% function
% MGT upper outer diamond
%
% Xu Yi, 2018

%%
function [iNO_end, iEL_end] = PP_model_Upper(fileID, iNO, iEL, cvLineNum, diamondNum, FZ)
%% NODE
fprintf(fileID,'*NODE    ; Nodes\n');
fprintf(fileID,'; iNO, X, Y, Z\n');

[upperMatrix, upperDersMatrix] = PP_model_UpperRead(cvLineNum, diamondNum);
fprintf(fileID,'; 上层网格外 节点\n');
iNO_Upper_init = iNO; % 备份
for i = 1:diamondNum+1 % i最大 奇数列+1，偶数列不+1
    for j = 1:cvLineNum
        if rem(j,2) ~= 1 % 偶数列
            if i == diamondNum+1
                break
            end
        end
        iNO = iNO+1;
        fprintf(fileID,'   %d, %.4f, %.4f, %.4f\n',...
            iNO,upperMatrix(j,i,1),upperMatrix(j,i,2),upperMatrix(j,i,3));
    end
end
iNO_Upper_end = iNO;
iNO_end = iNO;
fprintf(fileID,'\n');

%% ELEMENT(frame) diamonds
% fprintf(fileID,'*ELEMENT    ; Elements\n');
% fprintf(fileID,'; iEL, TYPE, iMAT, iPRO, iN1, iN2, ANGLE, iSUB, EXVAL, iOPT(EXVAL2) ; Frame  Element\n; iEL, TYPE, iMAT, iPRO, iN1, iN2, ANGLE, iSUB, EXVAL, EXVAL2, bLMT ; Comp/Tens Truss\n; iEL, TYPE, iMAT, iPRO, iN1, iN2, iN3, iN4, iSUB, iWID , LCAXIS    ; Planar Element\n; iEL, TYPE, iMAT, iPRO, iN1, iN2, iN3, iN4, iN5, iN6, iN7, iN8     ; Solid  Element\n');
% ELE_TYPE = 'BEAM'; ELE_iMAT = 1; ELE_ANGLE = 0; ELE_iSUB = 0;  % iMAT = 1材料钢结构Q345
%
% fprintf(fileID,'; 上层网格外 杆件\n');
% ELE_iPRO = 2;
% iNO = iNO_Upper_init; % 初始化iNO
% for i = 1:Upper_Z_num % 此处与上不同 类似柱子，循环数为层数-1
%     for j = 1:Stadium_arc_num+1	% 奇数层、偶数层略有不同(由于节点数不同)
%         if rem(i,2) == 0 && j == Stadium_arc_num+1
%         else
%             iNO = iNO+1; % 逐点定义
%         end
%         iN1 = iNO; % 杆件第一点
%         for k = 1:2 % 斜交网格,一个点连上面两个点
%             if rem(i,2) == 1 % 奇数层 % 第一个点和最后一个点各只连一个点
%                 if j == 1 && k == 1
%                     continue
%                 elseif j == Stadium_arc_num+1 && k == 2
%                     continue
%                 else
%                     iN2 = iN1+Stadium_arc_num+k-1;
%                 end
%             else % 偶数层 %没有最后一个点(即没有j = Stadium_arc_num+1)
%                 if j == Stadium_arc_num+1
%                     continue
%                 else
%                     iN2 = iN1+Stadium_arc_num+k-1;
%                 end
%             end
%             iEL = iEL+1;
%             fprintf(fileID,'   %d, %s, %d, %d, %d, %d, %d, %d\n',...
%                 iEL, ELE_TYPE, ELE_iMAT, ELE_iPRO,...
%                 iN1, iN2,...    % 斜交网格单元的两个节点号
%                 ELE_ANGLE, ELE_iSUB);
%         end
%     end
% end
iEL_end = iEL;
% fprintf(fileID,'\n');

%% CONLOAD (nodal loads)
% fprintf(fileID,'*CONLOAD    ; Nodal Loads');
% fprintf(fileID,'; NODE_LIST, FX, FY, FZ, MX, MY, MZ, GROUP');
%
% fprintf(fileID,'; 上层网格外 杆件节点力\n');
% for iNO = iNO_Upper_init+1:iNO_Upper_end
%     fprintf(fileID,'   %d, 0, 0, %d, 0, 0, 0, \n',...
%         iNO, FZ);
% end
% fprintf(fileID,'\n');

%% CONSTRAINT
% fprintf(fileID,'*CONSTRAINT    ; Supports\n');
% fprintf(fileID,'; NODE_LIST, CONST(Dx,Dy,Dz,Rx,Ry,Rz), GROUP\n');
%
% fprintf(fileID,'; 上层网格外 上部节点xy两向约束\n');
% iNO = iNO_Upper_end; % 初始化iNO
% NODE_LIST = sprintf('%dto%d', iNO-Stadium_arc_num, iNO);
% CONSTRAINT = 110000; % xy两向自由度约束
% fprintf(fileID,'   %s, %d, \n',...
%     NODE_LIST, CONSTRAINT);
% fprintf(fileID,'\n');

end
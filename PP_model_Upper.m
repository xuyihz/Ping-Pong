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
fprintf(fileID,'; �ϲ������� �ڵ�\n');
iNO_Upper_init = iNO; % ����
for i = 1:diamondNum+1 % i��� ������+1��ż���в�+1
    for j = 1:cvLineNum
        if rem(j,2) ~= 1 % ż����
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
% ELE_TYPE = 'BEAM'; ELE_iMAT = 1; ELE_ANGLE = 0; ELE_iSUB = 0;  % iMAT = 1���ϸֽṹQ345
%
% fprintf(fileID,'; �ϲ������� �˼�\n');
% ELE_iPRO = 2;
% iNO = iNO_Upper_init; % ��ʼ��iNO
% for i = 1:Upper_Z_num % �˴����ϲ�ͬ �������ӣ�ѭ����Ϊ����-1
%     for j = 1:Stadium_arc_num+1	% �����㡢ż�������в�ͬ(���ڽڵ�����ͬ)
%         if rem(i,2) == 0 && j == Stadium_arc_num+1
%         else
%             iNO = iNO+1; % ��㶨��
%         end
%         iN1 = iNO; % �˼���һ��
%         for k = 1:2 % б������,һ����������������
%             if rem(i,2) == 1 % ������ % ��һ��������һ�����ֻ��һ����
%                 if j == 1 && k == 1
%                     continue
%                 elseif j == Stadium_arc_num+1 && k == 2
%                     continue
%                 else
%                     iN2 = iN1+Stadium_arc_num+k-1;
%                 end
%             else % ż���� %û�����һ����(��û��j = Stadium_arc_num+1)
%                 if j == Stadium_arc_num+1
%                     continue
%                 else
%                     iN2 = iN1+Stadium_arc_num+k-1;
%                 end
%             end
%             iEL = iEL+1;
%             fprintf(fileID,'   %d, %s, %d, %d, %d, %d, %d, %d\n',...
%                 iEL, ELE_TYPE, ELE_iMAT, ELE_iPRO,...
%                 iN1, iN2,...    % б������Ԫ�������ڵ��
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
% fprintf(fileID,'; �ϲ������� �˼��ڵ���\n');
% for iNO = iNO_Upper_init+1:iNO_Upper_end
%     fprintf(fileID,'   %d, 0, 0, %d, 0, 0, 0, \n',...
%         iNO, FZ);
% end
% fprintf(fileID,'\n');

%% CONSTRAINT
% fprintf(fileID,'*CONSTRAINT    ; Supports\n');
% fprintf(fileID,'; NODE_LIST, CONST(Dx,Dy,Dz,Rx,Ry,Rz), GROUP\n');
%
% fprintf(fileID,'; �ϲ������� �ϲ��ڵ�xy����Լ��\n');
% iNO = iNO_Upper_end; % ��ʼ��iNO
% NODE_LIST = sprintf('%dto%d', iNO-Stadium_arc_num, iNO);
% CONSTRAINT = 110000; % xy�������ɶ�Լ��
% fprintf(fileID,'   %s, %d, \n',...
%     NODE_LIST, CONSTRAINT);
% fprintf(fileID,'\n');

end
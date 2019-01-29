%% function
% MGT model
%
% Xu Yi, 2019

%%
function [upperMatrix, upperDersMatrix] = PP_model_UpperRead(cvLineNum, diamondNum)
fileFolder = 'Raw\Upper\';
fileExtension = '.txt';
upperMatrix = zeros(cvLineNum, diamondNum+1, 3); % 3d pt
upperDersMatrix = zeros(cvLineNum, diamondNum+1, 3); % 一阶导数
for i = 1:cvLineNum
    filePath = sprintf('%s%d%s', fileFolder, i, fileExtension);
    [degree, knotVector, cvPt] = importRhinoCurve(filePath);
    weightVector = ones(1,length(knotVector)-degree-1);
    curve = zeros(diamondNum+1,3);
    dersCurve = zeros(diamondNum+1,degree+1,3);
    if rem(i,2) == 1 % 奇数
        U = linspace(knotVector(1),knotVector(end),diamondNum+1);
    else % 偶数列比奇数列少一个点，即最后一个值为0
        knot_itvl = ( knotVector(end) - knotVector(1) ) /diamondNum /2;
        U = linspace(knotVector(1)+knot_itvl, knotVector(end)-knot_itvl, diamondNum);
    end
    for j = 1:length(U)
        u = U(j);
        [curve(j,:), dersCurve(j,:,:)] = NurbsCrvPt(u, degree, knotVector, cvPt, weightVector);
    end
    upperMatrix(i,:,:) = curve(:,:);
    upperDersMatrix(i,:,:) = dersCurve(:,2,:);
end
end

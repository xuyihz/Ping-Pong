%% function
% MGT initial conditions
% 
% Xu Yi, 2018

%%
function PP_init(fileID)
%%
fprintf(fileID,...
    ';---------------------------------------------------------------------------\n'...
    );
fprintf(fileID,';  midas Gen Text(MGT) File.\n');
fprintf(fileID,';  Date : %s\n',datetime('today'));
fprintf(fileID,...
    ';---------------------------------------------------------------------------\n'...
    );
fprintf(fileID,'\n');

%% VERSION
fprintf(fileID,'*VERSION\n');
fprintf(fileID,'   8.7.5\n');
fprintf(fileID,'\n');

%% UNIT
FORCE = 'KN'; LENGTH = 'MM'; HEAT = 'KJ'; TEMPER = 'C';

fprintf(fileID,'*UNIT    ; Unit System\n');
fprintf(fileID,'; FORCE, LENGTH, HEAT, TEMPER\n');
fprintf(fileID,'   %s, %s, %s, %s\n',FORCE,LENGTH,HEAT,TEMPER);
fprintf(fileID,'\n');

%% STRUCTYPE
iSTYP = '0'; iMASS = '1'; iSMAS = '1'; bMASSOFFSET = 'NO';
bSELFWEIGHT = 'YES'; GRAV = '9806'; TEMPER = '0';
bALIGNBEAM = 'NO'; bALIGNSLAB = 'NO'; bROTRIGID = 'NO';

fprintf(fileID,'*STRUCTYPE    ; Structure Type\n');
fprintf(fileID,'; iSTYP, iMASS, iSMAS, bMASSOFFSET, bSELFWEIGHT, GRAV, TEMPER, bALIGNBEAM, bALIGNSLAB, bROTRIGID\n');
fprintf(fileID,'   %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n',...
    iSTYP, iMASS, iSMAS, bMASSOFFSET, bSELFWEIGHT, ...
    GRAV, TEMPER, bALIGNBEAM, bALIGNSLAB, bROTRIGID);
fprintf(fileID,'\n');

%% REBAR-MATL-CODE
CONC_CODE = 'GB10(RC)'; CONC_MDB = 'HRB400';
SRC_CODE = 'GB10(RC)'; SRC_MDB = 'HRB400';

fprintf(fileID,'*REBAR-MATL-CODE    ; Rebar Material Code\n');
fprintf(fileID,'; CONC_CODE, CONC_MDB, SRC_CODE, SRC_MDB\n');
fprintf(fileID,'   %s, %s, %s, %s\n',CONC_CODE,CONC_MDB,SRC_CODE,SRC_MDB);
fprintf(fileID,'\n');

%% STLDCASE
LCNAME = {'DL';'LL';'WX';'WY'};
LCTYPE = {'D';'L';'W';'W'};
DESC = {'Dead Load';'Live Load';'Wind X';'Wind Y'};

fprintf(fileID,'*STLDCASE    ; Static Load Cases\n');
fprintf(fileID,'; LCNAME, LCTYPE, DESC\n');
for i = 1:length(LCNAME)
    LCN = LCNAME{i}; LCT = LCTYPE{i}; DES = DESC{i};
    fprintf(fileID,'   %s, %s, %s\n',LCN,LCT,DES);
end
fprintf(fileID,'\n');

%% SELFWEIGHT
fprintf(fileID,'*USE-STLD, DL\n');
fprintf(fileID,'; *SELFWEIGHT, X, Y, Z, GROUP\n');
fprintf(fileID,'*SELFWEIGHT, 0, 0, -1, \n');
fprintf(fileID,'\n');

%% MATERIAL
% 目前只定义了Q345, C30
fprintf(fileID,'*MATERIAL    ; Material\n');
fprintf(fileID,'; iMAT, TYPE, MNAME, SPHEAT, HEATCO, PLAST, TUNIT, bMASS, DAMPRATIO, [DATA1]           ; STEEL, CONC, USER\n; iMAT, TYPE, MNAME, SPHEAT, HEATCO, PLAST, TUNIT, bMASS, DAMPRATIO, [DATA2], [DATA2]  ; SRC\n; [DATA1] : 1, DB, NAME, CODE, USEELAST, ELAST\n; [DATA1] : 2, ELAST, POISN, THERMAL, DEN, MASS\n; [DATA1] : 3, Ex, Ey, Ez, Tx, Ty, Tz, Sxy, Sxz, Syz, Pxy, Pxz, Pyz, DEN, MASS         ; Orthotropic\n; [DATA2] : 1, DB, NAME, CODE, USEELAST, ELAST or 2, ELAST, POISN, THERMAL, DEN, MASS\n');
fprintf(fileID,'   1, STEEL, Q345, 0, 0, , C, NO, 0.02, 1, GB 50917-13(S), , Q345, NO, 206000\n');
fprintf(fileID,'   2, CONC, C30, 0, 0, , C, NO, 0.05, 1, GB 50917-13(RC), , C30, NO, 30000\n');
fprintf(fileID,'\n');

end
%% function
% MGT initial conditions
% 
% Xu Yi, 2019

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
fprintf(fileID,'   8.8.0\n');
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

%% SECTION
SEC_B400x10_num = '1'; SEC_B300x10_num = '2'; SEC_B200x8_num = '3'; SEC_B200x6_num = '4';
SEC_B400x10_SNAME = 'B 400x10'; SEC_B300x10_SNAME = 'B 300x10'; SEC_B200x8_SNAME = 'B 200x8'; SEC_B200x6_SNAME = 'B 200x6';
SEC_TYPE = 'DBUSER'; SEC_OFFSET = 'CC'; SEC_0 = '0'; SEC_1 = '1'; SEC_YES = 'YES'; SEC_NO = 'NO'; SEC_B = 'B';  SEC_GB = 'GB-YB05';

fprintf(fileID,'*SECTION    ; Section\n');
fprintf(fileID,'; iSEC, TYPE, SNAME, [OFFSET], bSD, bWE, SHAPE, [DATA1], [DATA2]                    ; 1st line - DB/USER\n; iSEC, TYPE, SNAME, [OFFSET], bSD, bWE, SHAPE, BLT, D1, ..., D8, iCEL              ; 1st line - VALUE\n;       AREA, ASy, ASz, Ixx, Iyy, Izz                                               ; 2nd line\n;       CyP, CyM, CzP, CzM, QyB, QzB, PERI_OUT, PERI_IN, Cy, Cz                     ; 3rd line\n;       Y1, Y2, Y3, Y4, Z1, Z2, Z3, Z4, Zyy, Zzz                                    ; 4th line\n; iSEC, TYPE, SNAME, [OFFSET], bSD, bWE, SHAPE, ELAST, DEN, POIS, POIC, SF, THERMAL ; 1st line - SRC\n;       D1, D2, [SRC]                                                               ; 2nd line\n; iSEC, TYPE, SNAME, [OFFSET], bSD, bWE, SHAPE, 1, DB, NAME1, NAME2, D1, D2         ; 1st line - COMBINED\n; iSEC, TYPE, SNAME, [OFFSET], bSD, bWE, SHAPE, 2, D11, D12, D13, D14, D15, D21, D22, D23, D24\n; iSEC, TYPE, SNAME, [OFFSET2], bSD, bWE, SHAPE, iyVAR, izVAR, STYPE                ; 1st line - TAPERED\n;       DB, NAME1, NAME2                                                            ; 2nd line(STYPE=DB)\n;       [DIM1], [DIM2]                                                              ; 2nd line(STYPE=USER)\n;       D11, D12, D13, D14, D15, D16, D17, D18                                      ; 2nd line(STYPE=VALUE)\n;       AREA1, ASy1, ASz1, Ixx1, Iyy1, Izz1                                         ; 3rd line(STYPE=VALUE)\n;       CyP1, CyM1, CzP1, CzM1, QyB1, QzB1, PERI_OUT1, PERI_IN1, Cy1, Cz1           ; 4th line(STYPE=VALUE)\n;       Y11, Y12, Y13, Y14, Z11, Z12, Z13, Z14, Zyy1, Zyy2                          ; 5th line(STYPE=VALUE)\n;       D21, D22, D23, D24, D25, D26, D27, D28                                      ; 6th line(STYPE=VALUE)\n;       AREA2, ASy2, ASz2, Ixx2, Iyy2, Izz2                                         ; 7th line(STYPE=VALUE)\n;       CyP2, CyM2, CzP2, CzM2, QyB2, QzB2, PERI_OUT2, PERI_IN2, Cy2, Cz2           ; 8th line(STYPE=VALUE)\n;       Y21, Y22, Y23, Y24, Z21, Z22, Z23, Z24, Zyy2, Zzz2                          ; 9th line(STYPE=VALUE)\n; [DATA1] : 1, DB, NAME or 2, D1, D2, D3, D4, D5, D6, D7, D8, D9, D10\n; [DATA2] : CCSHAPE or iCEL or iN1, iN2\n; [SRC]  : 1, DB, NAME1, NAME2 or 2, D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, iN1, iN2\n; [DIM1], [DIM2] : D1, D2, D3, D4, D5, D6, D7, D8\n; [OFFSET] : OFFSET, iCENT, iREF, iHORZ, HUSER, iVERT, VUSER\n; [OFFSET2]: OFFSET, iCENT, iREF, iHORZ, HUSERI, HUSERJ, iVERT, VUSERI, VUSERJ\n');

fprintf(fileID,'   %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n',...
    SEC_B400x10_num,SEC_TYPE,SEC_B400x10_SNAME,...
    SEC_OFFSET,SEC_0,SEC_0,SEC_0,SEC_0,SEC_0,SEC_0,SEC_YES,SEC_NO,...
    SEC_B,SEC_1,SEC_GB,SEC_B400x10_SNAME);
fprintf(fileID,'   %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n',...
    SEC_B300x10_num,SEC_TYPE,SEC_B300x10_SNAME,...
    SEC_OFFSET,SEC_0,SEC_0,SEC_0,SEC_0,SEC_0,SEC_0,SEC_YES,SEC_NO,...
    SEC_B,SEC_1,SEC_GB,SEC_B300x10_SNAME);
fprintf(fileID,'   %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n',...
    SEC_B200x8_num,SEC_TYPE,SEC_B200x8_SNAME,...
    SEC_OFFSET,SEC_0,SEC_0,SEC_0,SEC_0,SEC_0,SEC_0,SEC_YES,SEC_NO,...
    SEC_B,SEC_1,SEC_GB,SEC_B200x8_SNAME);
fprintf(fileID,'   %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n',...
    SEC_B200x6_num,SEC_TYPE,SEC_B200x6_SNAME,...
    SEC_OFFSET,SEC_0,SEC_0,SEC_0,SEC_0,SEC_0,SEC_0,SEC_YES,SEC_NO,...
    SEC_B,SEC_1,SEC_GB,SEC_B200x6_SNAME);
fprintf(fileID,'\n');

%% THICKNESS
THICK_1_num = '1';
THICK_1 = '1';
THICK_TYPE = 'VALUE'; THICK_bSAME = 'YES';
THICK_bOFFSET = 'NO'; THICK_OFFTYPE = '0'; THICK_VALUE = '0';

fprintf(fileID,'*THICKNESS    ; Thickness\n');
fprintf(fileID,'; iTHK, TYPE, bSAME, THIK-IN, THIK-OUT, bOFFSET, OFFTYPE, VALUE ; TYPE=VALUE\n; iTHK, TYPE, SUBTYPE, RPOS, WEIGHT                             ; TYPE=STIFFENED, SUBTYPE=VALUE\n;       SHAPE, THIK-IN, THIK-OUT, HU, HL                        ;      for yz section\n;       SHAPE, THIK-IN, THIK-OUT, HU, HL                        ;      for xz section\n; iTHK, TYPE, SUBTYPE, RPOS, PLATETHIK                          ; TYPE=STIFFENED, SUBTYPE=USER\n;       bRIB {, SHAPE, DIST, SIZE1, SIZE2, ..., SIZE6}          ;      for yz section\n;       bRIB {, SHAPE, DIST, SIZE2, SIZE2, ..., SIZE6}          ;      for xz section\n; iTHK, TYPE, SUBTYPE, RPOS, PLATETHIK, DBNAME                  ; TYPE=STIFFENED, SUBTYPE=DB\n;       bRIB {, SHAPE, DIST, SNAME}                             ;      for yz section\n;       bRIB {, SHAPE, DIST, SNAME}                             ;      for xz section\n');
fprintf(fileID,'   %s, %s, %s, %s, %s, %s, %s, %s\n',...
    THICK_1_num,THICK_TYPE,THICK_bSAME,THICK_1,THICK_1,THICK_bOFFSET,THICK_OFFTYPE,THICK_VALUE);
fprintf(fileID,'\n');

end
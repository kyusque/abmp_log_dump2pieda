#!/usr/bin/env -S cwltool --outdir test --parallel
class: Workflow
cwlVersion: v1.0
inputs: {}
outputs:
    ajf:
        type: File
        outputSource: abinitmp/ajf
    log:
        type: File
        outputSource: abinitmp/log
    cpf:
        type: File
        outputSource: abinitmp/cpf
    pdb:
        type: File
        outputSource: abinitmp/pdb

steps:
    abinitmp:
        run:
            class: CommandLineTool
            cwlVersion: v1.0
            baseCommand: sh
            arguments: 
                - -c 
                - abinitmp_smp < test2.ajf
            stdout: test2.log
            inputs: {}
            outputs:
                log:
                    type: stdout
                cpf:
                    type: File
                    outputBinding:
                        glob: test2.cpf
                pdb:
                    type: File
                    outputBinding:
                        glob: test2.pdb
                ajf:
                    type: File
                    outputBinding:
                        glob: test2.ajf
        in: {}
        out:
            - log
            - cpf
            - pdb
            - ajf


requirements:
    InitialWorkDirRequirement:
        listing:
            - entryname: test2.ajf
              entry: |
                &CNTRL
                Method='MP2'
                Memory=3000
                ReadGeom='test2.pdb'
                WriteGeom='test2.cpf'
                Charge=-1
                /
                &FMOCNTRL
                FMO='ON'
                NBody=2
                AutoFrag='ON'
                FragSizeAminoacid='/amino'
                /
                &SCF
                MaxSCFenergy=1.0e-6
                MaxSCFdensity=1.0e-4
                MaxSCFcyc=1000
                /
                &BASIS
                BasisSet='STO-3G'
                /
                &OPTCNTRL
                /
                &MFMO
                /
                &SCZV
                /
                &XUFF
                /
                &MP2
                /
                &MP2DNS
                /
                &MP2GRD
                /
                &MP3
                /
                &LMP2
                /
                &LRD
                /
                &DFT
                /
                &ANALYSIS
                PIEDA='YES'
                /
                &BSSE
                /
                &FRAGPAIR
                /
                &SOLVATION
                /
                &PBEQ
                /
                &POP
                /
                &GRIDCNTRL
                /
                &MCP
                /
                &CIS
                /
                &CISGRD
                /
                &CAFI
                /
                &POL
                /
                &GF2
                /
                &CCPT
                /
                &XYZ
                /
                &FRAGMENT
                /
                &MDCNTRL
                /
                &VEL
                /
                &NHC
                /
                &TYPFRAG
                /
            - entryname: test2.pdb
              entry: |
                ATOM      1  N   CYS A   1       1.599   8.433  -3.818  1.00  0.00           N1+
                ATOM      2  CA  CYS A   1       1.847   6.965  -3.732  1.00  0.00           C  
                ATOM      3  C   CYS A   1       0.519   6.203  -3.762  1.00  0.00           C  
                ATOM      4  O   CYS A   1      -0.528   6.772  -4.004  1.00  0.00           O  
                ATOM      5  CB  CYS A   1       2.628   6.709  -2.441  1.00  0.00           C  
                ATOM      6  SG  CYS A   1       3.585   5.189  -2.464  1.00  0.00           S  
                ATOM      7  H1  CYS A   1       1.012   8.717  -3.044  1.00  0.00           H  
                ATOM      8  H2  CYS A   1       1.097   8.634  -4.673  1.00  0.00           H  
                ATOM      9  H3  CYS A   1       2.469   8.945  -3.799  1.00  0.00           H  
                ATOM     10  HA  CYS A   1       2.482   6.638  -4.555  1.00  0.00           H  
                ATOM     11  HB2 CYS A   1       3.341   7.521  -2.288  1.00  0.00           H  
                ATOM     12  HB3 CYS A   1       1.948   6.692  -1.585  1.00  0.00           H  
                ATOM     13  N   CYS A   2       0.552   4.921  -3.518  1.00  0.00           N  
                ATOM     14  CA  CYS A   2      -0.710   4.128  -3.532  1.00  0.00           C  
                ATOM     15  C   CYS A   2      -1.549   4.449  -2.291  1.00  0.00           C  
                ATOM     16  O   CYS A   2      -1.267   5.382  -1.566  1.00  0.00           O  
                ATOM     17  CB  CYS A   2      -0.274   2.675  -3.640  1.00  0.00           C  
                ATOM     18  SG  CYS A   2       0.905   2.243  -2.358  1.00  0.00           S  
                ATOM     19  H   CYS A   2       1.406   4.448  -3.256  1.00  0.00           H  
                ATOM     20  HA  CYS A   2      -1.298   4.325  -4.430  1.00  0.00           H  
                ATOM     21  HB2 CYS A   2      -1.135   2.009  -3.602  1.00  0.00           H  
                ATOM     22  HB3 CYS A   2       0.215   2.529  -4.604  1.00  0.00           H  
                ATOM     23  N   ASN A   3      -2.577   3.685  -2.042  1.00  0.00           N  
                ATOM     24  CA  ASN A   3      -3.429   3.951  -0.848  1.00  0.00           C  
                ATOM     25  C   ASN A   3      -3.235   2.847   0.194  1.00  0.00           C  
                ATOM     26  O   ASN A   3      -3.186   1.677  -0.126  1.00  0.00           O  
                ATOM     27  CB  ASN A   3      -4.882   3.964  -1.374  1.00  0.00           C  
                ATOM     28  CG  ASN A   3      -5.274   2.657  -2.072  1.00  0.00           C  
                ATOM     29  OD1 ASN A   3      -4.716   2.277  -3.090  1.00  0.00           O  
                ATOM     30  ND2 ASN A   3      -6.182   1.898  -1.512  1.00  0.00           N  
                ATOM     31  H   ASN A   3      -2.780   2.894  -2.635  1.00  0.00           H  
                ATOM     32  HA  ASN A   3      -3.218   4.919  -0.391  1.00  0.00           H  
                ATOM     33  HB2 ASN A   3      -5.563   4.157  -0.548  1.00  0.00           H  
                ATOM     34  HB3 ASN A   3      -4.998   4.773  -2.095  1.00  0.00           H  
                ATOM     35 HD21 ASN A   3      -6.642   2.187  -0.662  1.00  0.00           H  
                ATOM     36 HD22 ASN A   3      -6.331   0.984  -1.927  1.00  0.00           H  
                ATOM     37  N   CYS A   4      -3.119   3.214   1.442  1.00  0.00           N  
                ATOM     38  CA  CYS A   4      -2.923   2.190   2.508  1.00  0.00           C  
                ATOM     39  C   CYS A   4      -4.197   1.361   2.697  1.00  0.00           C  
                ATOM     40  O   CYS A   4      -4.226   0.420   3.465  1.00  0.00           O  
                ATOM     41  CB  CYS A   4      -2.625   2.910   3.830  1.00  0.00           C  
                ATOM     42  SG  CYS A   4      -0.986   3.646   4.020  1.00  0.00           S  
                ATOM     43  H   CYS A   4      -3.035   4.190   1.682  1.00  0.00           H  
                ATOM     44  HA  CYS A   4      -2.093   1.520   2.272  1.00  0.00           H  
                ATOM     45  HB2 CYS A   4      -3.370   3.690   3.984  1.00  0.00           H  
                ATOM     46  HB3 CYS A   4      -2.743   2.194   4.646  1.00  0.00           H  
                ATOM     47  N   SER A   5      -5.250   1.702   2.005  1.00  0.00           N  
                ATOM     48  CA  SER A   5      -6.518   0.929   2.152  1.00  0.00           C  
                ATOM     49  C   SER A   5      -6.415  -0.407   1.412  1.00  0.00           C  
                ATOM     50  O   SER A   5      -7.296  -1.240   1.493  1.00  0.00           O  
                ATOM     51  CB  SER A   5      -7.734   1.736   1.656  1.00  0.00           C  
                ATOM     52  OG  SER A   5      -7.391   2.912   0.938  1.00  0.00           O  
                ATOM     53  H   SER A   5      -5.247   2.552   1.467  1.00  0.00           H  
                ATOM     54  HA  SER A   5      -6.747   0.744   3.202  1.00  0.00           H  
                ATOM     55  HB2 SER A   5      -8.374   1.107   1.035  1.00  0.00           H  
                ATOM     56  HB3 SER A   5      -8.316   2.035   2.529  1.00  0.00           H  
                ATOM     57  HG  SER A   5      -8.182   3.465   0.890  1.00  0.00           H  
                ATOM     58  N   SER A   6      -5.348  -0.618   0.691  1.00  0.00           N  
                ATOM     59  CA  SER A   6      -5.194  -1.901  -0.053  1.00  0.00           C  
                ATOM     60  C   SER A   6      -3.893  -2.599   0.350  1.00  0.00           C  
                ATOM     61  O   SER A   6      -2.839  -1.995   0.386  1.00  0.00           O  
                ATOM     62  CB  SER A   6      -5.188  -1.611  -1.557  1.00  0.00           C  
                ATOM     63  OG  SER A   6      -6.431  -1.054  -1.947  1.00  0.00           O  
                ATOM     64  H   SER A   6      -4.587   0.051   0.688  1.00  0.00           H  
                ATOM     65  HA  SER A   6      -6.022  -2.590   0.118  1.00  0.00           H  
                ATOM     66  HB2 SER A   6      -4.385  -0.910  -1.795  1.00  0.00           H  
                ATOM     67  HB3 SER A   6      -5.023  -2.539  -2.105  1.00  0.00           H  
                ATOM     68  HG  SER A   6      -7.143  -1.583  -1.571  1.00  0.00           H  
                ATOM     69  N   ALA A   7      -3.957  -3.868   0.651  1.00  0.00           N  
                ATOM     70  CA  ALA A   7      -2.722  -4.604   1.049  1.00  0.00           C  
                ATOM     71  C   ALA A   7      -1.657  -4.466  -0.043  1.00  0.00           C  
                ATOM     72  O   ALA A   7      -0.479  -4.361   0.235  1.00  0.00           O  
                ATOM     73  CB  ALA A   7      -3.081  -6.073   1.301  1.00  0.00           C  
                ATOM     74  H   ALA A   7      -4.845  -4.342   0.687  1.00  0.00           H  
                ATOM     75  HA  ALA A   7      -2.317  -4.189   1.975  1.00  0.00           H  
                ATOM     76  HB1 ALA A   7      -3.496  -6.526   0.400  1.00  0.00           H  
                ATOM     77  HB2 ALA A   7      -2.175  -6.617   1.582  1.00  0.00           H  
                ATOM     78  HB3 ALA A   7      -3.801  -6.147   2.116  1.00  0.00           H  
                ATOM     79  N   ALA A   8      -2.065  -4.458  -1.283  1.00  0.00           N  
                ATOM     80  CA  ALA A   8      -1.079  -4.316  -2.392  1.00  0.00           C  
                ATOM     81  C   ALA A   8      -0.262  -3.041  -2.186  1.00  0.00           C  
                ATOM     82  O   ALA A   8       0.951  -3.050  -2.239  1.00  0.00           O  
                ATOM     83  CB  ALA A   8      -1.831  -4.313  -3.729  1.00  0.00           C  
                ATOM     84  H   ALA A   8      -3.037  -4.607  -1.490  1.00  0.00           H  
                ATOM     85  HA  ALA A   8      -0.394  -5.167  -2.393  1.00  0.00           H  
                ATOM     86  HB1 ALA A   8      -2.540  -3.485  -3.769  1.00  0.00           H  
                ATOM     87  HB2 ALA A   8      -1.113  -4.208  -4.545  1.00  0.00           H  
                ATOM     88  HB3 ALA A   8      -2.365  -5.256  -3.853  1.00  0.00           H  
                ATOM     89  N   CYS A   9      -0.923  -1.944  -1.938  1.00  0.00           N  
                ATOM     90  CA  CYS A   9      -0.191  -0.667  -1.710  1.00  0.00           C  
                ATOM     91  C   CYS A   9       0.838  -0.860  -0.600  1.00  0.00           C  
                ATOM     92  O   CYS A   9       2.007  -0.565  -0.753  1.00  0.00           O  
                ATOM     93  CB  CYS A   9      -1.117   0.413  -1.245  1.00  0.00           C  
                ATOM     94  SG  CYS A   9      -0.235   1.917  -0.736  1.00  0.00           S  
                ATOM     95  H   CYS A   9      -1.911  -1.992  -1.754  1.00  0.00           H  
                ATOM     96  HA  CYS A   9       0.304  -0.337  -2.624  1.00  0.00           H  
                ATOM     97  HB2 CYS A   9      -1.837   0.643  -2.028  1.00  0.00           H  
                ATOM     98  HB3 CYS A   9      -1.649   0.024  -0.379  1.00  0.00           H  
                ATOM     99  N   ALA A  10       0.399  -1.357   0.518  1.00  0.00           N  
                ATOM    100  CA  ALA A  10       1.323  -1.581   1.660  1.00  0.00           C  
                ATOM    101  C   ALA A  10       2.441  -2.555   1.270  1.00  0.00           C  
                ATOM    102  O   ALA A  10       3.529  -2.509   1.807  1.00  0.00           O  
                ATOM    103  CB  ALA A  10       0.503  -2.101   2.846  1.00  0.00           C  
                ATOM    104  H   ALA A  10      -0.560  -1.659   0.602  1.00  0.00           H  
                ATOM    105  HA  ALA A  10       1.788  -0.638   1.953  1.00  0.00           H  
                ATOM    106  HB1 ALA A  10       0.050  -3.061   2.596  1.00  0.00           H  
                ATOM    107  HB2 ALA A  10       1.162  -2.237   3.705  1.00  0.00           H  
                ATOM    108  HB3 ALA A  10      -0.275  -1.382   3.106  1.00  0.00           H  
                ATOM    109  N   ASP A  11       2.181  -3.443   0.347  1.00  0.00           N  
                ATOM    110  CA  ASP A  11       3.234  -4.421  -0.058  1.00  0.00           C  
                ATOM    111  C   ASP A  11       4.025  -3.905  -1.266  1.00  0.00           C  
                ATOM    112  O   ASP A  11       5.234  -4.020  -1.319  1.00  0.00           O  
                ATOM    113  CB  ASP A  11       2.563  -5.756  -0.451  1.00  0.00           C  
                ATOM    114  CG  ASP A  11       2.217  -6.668   0.732  1.00  0.00           C  
                ATOM    115  OD1 ASP A  11       1.008  -6.865   0.995  1.00  0.00           O  
                ATOM    116  OD2 ASP A  11       3.168  -7.251   1.298  1.00  0.00           O1-
                ATOM    117  H   ASP A  11       1.224  -3.611   0.068  1.00  0.00           H  
                ATOM    118  HA  ASP A  11       3.933  -4.638   0.753  1.00  0.00           H  
                ATOM    119  HB2 ASP A  11       1.670  -5.559  -1.046  1.00  0.00           H  
                ATOM    120  HB3 ASP A  11       3.251  -6.311  -1.092  1.00  0.00           H  
                ATOM    121  N   HIS A  12       3.357  -3.352  -2.240  1.00  0.00           N  
                ATOM    122  CA  HIS A  12       4.076  -2.846  -3.447  1.00  0.00           C  
                ATOM    123  C   HIS A  12       4.611  -1.431  -3.212  1.00  0.00           C  
                ATOM    124  O   HIS A  12       5.076  -0.777  -4.124  1.00  0.00           O  
                ATOM    125  CB  HIS A  12       3.132  -2.883  -4.666  1.00  0.00           C  
                ATOM    126  CG  HIS A  12       2.956  -4.257  -5.261  1.00  0.00           C  
                ATOM    127  ND1 HIS A  12       3.204  -4.584  -6.597  1.00  0.00           N  
                ATOM    128  CD2 HIS A  12       2.600  -5.391  -4.591  1.00  0.00           C  
                ATOM    129  CE1 HIS A  12       3.007  -5.905  -6.696  1.00  0.00           C  
                ATOM    130  NE2 HIS A  12       2.641  -6.417  -5.508  1.00  0.00           N  
                ATOM    131  H   HIS A  12       2.489  -2.953  -1.976  1.00  0.00           H  
                ATOM    132  HA  HIS A  12       4.917  -3.486  -3.715  1.00  0.00           H  
                ATOM    133  HB2 HIS A  12       2.159  -2.470  -4.404  1.00  0.00           H  
                ATOM    134  HB3 HIS A  12       3.545  -2.256  -5.456  1.00  0.00           H  
                ATOM    135  HD2 HIS A  12       2.382  -5.462  -3.533  1.00  0.00           H  
                ATOM    136  HE2 HIS A  12       2.480  -7.394  -5.310  1.00  0.00           H  
                ATOM    137  HE1 HIS A  12       3.139  -6.475  -7.606  1.00  0.00           H  
                ATOM    138  N   SER A  13       4.550  -0.950  -2.001  1.00  0.00           N  
                ATOM    139  CA  SER A  13       5.058   0.423  -1.723  1.00  0.00           C  
                ATOM    140  C   SER A  13       5.342   0.592  -0.228  1.00  0.00           C  
                ATOM    141  O   SER A  13       4.672   0.021   0.610  1.00  0.00           O  
                ATOM    142  CB  SER A  13       4.062   1.510  -2.100  1.00  0.00           C  
                ATOM    143  OG  SER A  13       3.847   1.556  -3.496  1.00  0.00           O  
                ATOM    144  H   SER A  13       4.170  -1.503  -1.241  1.00  0.00           H  
                ATOM    145  HA  SER A  13       5.964   0.622  -2.295  1.00  0.00           H  
                ATOM    146  HB2 SER A  13       3.141   1.328  -1.564  1.00  0.00           H  
                ATOM    147  HB3 SER A  13       4.452   2.476  -1.781  1.00  0.00           H  
                ATOM    148  HG  SER A  13       4.197   0.719  -3.859  1.00  0.00           H  
                ATOM    149  N   ALA A  14       6.331   1.373   0.111  1.00  0.00           N  
                ATOM    150  CA  ALA A  14       6.658   1.578   1.552  1.00  0.00           C  
                ATOM    151  C   ALA A  14       6.132   2.937   2.024  1.00  0.00           C  
                ATOM    152  O   ALA A  14       6.560   3.462   3.032  1.00  0.00           O  
                ATOM    153  CB  ALA A  14       8.178   1.441   1.714  1.00  0.00           C  
                ATOM    154  H   ALA A  14       6.930   1.770  -0.592  1.00  0.00           H  
                ATOM    155  HA  ALA A  14       6.208   0.808   2.183  1.00  0.00           H  
                ATOM    156  HB1 ALA A  14       8.690   2.217   1.144  1.00  0.00           H  
                ATOM    157  HB2 ALA A  14       8.439   1.543   2.769  1.00  0.00           H  
                ATOM    158  HB3 ALA A  14       8.499   0.457   1.369  1.00  0.00           H  
                ATOM    159  N   CYS A  15       5.206   3.506   1.304  1.00  0.00           N  
                ATOM    160  CA  CYS A  15       4.652   4.829   1.713  1.00  0.00           C  
                ATOM    161  C   CYS A  15       3.776   4.672   2.960  1.00  0.00           C  
                ATOM    162  O   CYS A  15       3.441   5.636   3.620  1.00  0.00           O  
                ATOM    163  CB  CYS A  15       3.852   5.349   0.526  1.00  0.00           C  
                ATOM    164  SG  CYS A  15       4.880   5.540  -0.954  1.00  0.00           S  
                ATOM    165  H   CYS A  15       4.820   3.012   0.519  1.00  0.00           H  
                ATOM    166  HA  CYS A  15       5.451   5.541   1.927  1.00  0.00           H  
                ATOM    167  HB2 CYS A  15       3.045   4.644   0.319  1.00  0.00           H  
                ATOM    168  HB3 CYS A  15       3.411   6.311   0.792  1.00  0.00           H  
                ATOM    169  N   CYS A  16       3.405   3.465   3.289  1.00  0.00           N  
                ATOM    170  CA  CYS A  16       2.552   3.250   4.493  1.00  0.00           C  
                ATOM    171  C   CYS A  16       3.430   2.972   5.716  1.00  0.00           C  
                ATOM    172  OXT CYS A  16       4.607   2.564   5.554  1.00  0.00           O1-
                ATOM    173  O   CYS A  16       3.004   3.141   6.840  1.00  0.00           O  
                ATOM    174  CB  CYS A  16       1.609   2.075   4.177  1.00  0.00           C  
                ATOM    175  SG  CYS A  16       0.025   2.193   5.038  1.00  0.00           S  
                ATOM    176  H   CYS A  16       3.896   2.670   2.918  1.00  0.00           H  
                ATOM    177  HA  CYS A  16       1.926   4.115   4.706  1.00  0.00           H  
                ATOM    178  HB2 CYS A  16       1.411   2.032   3.107  1.00  0.00           H  
                ATOM    179  HB3 CYS A  16       2.108   1.150   4.473  1.00  0.00           H  
                TER     180      CYS A  16 

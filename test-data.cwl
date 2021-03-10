#!/usr/bin/env -S cwltool --outdir test --parallel --enable-ext --mpi-config-file mpi_config.yml
class: Workflow
cwlVersion: v1.0
inputs: 
    nproc:
        type: int
        default: 1
outputs:
    ajf:
        type: File
        outputSource: init/ajf
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
    init:
        run:
            class: CommandLineTool
            cwlVersion: v1.0
            baseCommand: echo
            arguments:
                - init
            inputs:
                nproc:
                    type: int
            outputs:
                ajf:
                    type: File
                    outputBinding:
                        glob: test.ajf
            requirements:
                InitialWorkDirRequirement:
                    listing:
                        - entryname: test.ajf
                          entry: |
                            &CNTRL
                            Method='MP2'
                            Memory=1000
                            ReadGeom='test.pdb'
                            WriteGeom='test.cpf'
                            ABINP='test.ajf'
                            Charge=10
                            /
                            &FMOCNTRL
                            FMO='ON'
                            NBody=2
                            AutoFrag='ON'
                            FragSizeAminoacid='/amino'
                            NP=$(inputs.nproc)
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
        in:
            nproc: nproc
        out:
            - ajf    
    abinitmp:
        run:
            class: CommandLineTool
            cwlVersion: v1.0
            $namespaces:
                cwltool: "http://commonwl.org/cwltool#"
            baseCommand: abinitmp
            stdin: $(inputs.ajf.path)
            stdout: test.log
            inputs: 
                ajf:
                    type: File
                    streamable: true
                nproc:
                    type: int
            outputs:
                log:
                    type: stdout
                cpf:
                    type: File
                    outputBinding:
                        glob: test.cpf
                pdb:
                    type: File
                    outputBinding:
                        glob: test.pdb
            requirements:
                cwltool:MPIRequirement:
                    processes: $(inputs.nproc)
                InitialWorkDirRequirement:
                    listing:
                        - entryname: test.pdb
                          entry: |
                            ATOM      1  N   ARG A   1     -11.625  -0.599   2.390  1.00  0.94           N1+
                            ATOM      2  CA  ARG A   1     -10.947   0.351   1.517  1.00  0.72           C  
                            ATOM      3  C   ARG A   1     -10.064  -0.410   0.538  1.00  0.60           C  
                            ATOM      4  O   ARG A   1      -8.936  -0.781   0.870  1.00  0.64           O  
                            ATOM      5  CB  ARG A   1     -10.107   1.337   2.336  1.00  1.24           C  
                            ATOM      6  CG  ARG A   1     -10.891   2.049   3.424  1.00  1.81           C  
                            ATOM      7  CD  ARG A   1     -12.049   2.842   2.849  1.00  2.42           C  
                            ATOM      8  NE  ARG A   1     -12.883   3.420   3.893  1.00  3.29           N  
                            ATOM      9  CZ  ARG A   1     -13.510   4.586   3.779  1.00  4.10           C  
                            ATOM     10  NH1 ARG A   1     -13.344   5.324   2.687  1.00  4.22           N  
                            ATOM     11  NH2 ARG A   1     -14.285   5.019   4.762  1.00  5.01           N1+
                            ATOM     12  H1  ARG A   1     -12.232  -0.128   3.047  1.00  0.94           H  
                            ATOM     13  H2  ARG A   1     -10.939  -1.128   2.920  1.00  0.94           H  
                            ATOM     14  H3  ARG A   1     -12.177  -1.261   1.859  1.00  0.94           H  
                            ATOM     15  HA  ARG A   1     -11.685   0.908   0.943  1.00  0.72           H  
                            ATOM     16  HB2 ARG A   1      -9.301   0.799   2.833  1.00  1.24           H  
                            ATOM     17  HB3 ARG A   1      -9.666   2.076   1.665  1.00  1.24           H  
                            ATOM     18  HG2 ARG A   1     -11.259   1.332   4.159  1.00  1.81           H  
                            ATOM     19  HG3 ARG A   1     -10.220   2.736   3.943  1.00  1.81           H  
                            ATOM     20  HD2 ARG A   1     -11.622   3.616   2.210  1.00  2.42           H  
                            ATOM     21  HD3 ARG A   1     -12.685   2.201   2.238  1.00  2.42           H  
                            ATOM     22  HE  ARG A   1     -12.990   2.931   4.768  1.00  3.29           H  
                            ATOM     23 HH11 ARG A   1     -12.724   5.035   1.963  1.00  4.22           H  
                            ATOM     24 HH12 ARG A   1     -13.810   6.214   2.619  1.00  4.22           H  
                            ATOM     25 HH21 ARG A   1     -14.415   4.480   5.601  1.00  5.01           H  
                            ATOM     26 HH22 ARG A   1     -14.760   5.903   4.681  1.00  5.01           H  
                            ATOM     27  N   ARG A   2     -10.590  -0.661  -0.657  1.00  0.54           N  
                            ATOM     28  CA  ARG A   2      -9.906  -1.495  -1.645  1.00  0.51           C  
                            ATOM     29  C   ARG A   2      -8.531  -0.942  -2.021  1.00  0.39           C  
                            ATOM     30  O   ARG A   2      -7.599  -1.700  -2.277  1.00  0.41           O  
                            ATOM     31  CB  ARG A   2     -10.770  -1.682  -2.903  1.00  0.59           C  
                            ATOM     32  CG  ARG A   2     -10.828  -0.483  -3.849  1.00  1.27           C  
                            ATOM     33  CD  ARG A   2     -11.654   0.665  -3.295  1.00  2.13           C  
                            ATOM     34  NE  ARG A   2     -11.756   1.764  -4.249  1.00  2.80           N  
                            ATOM     35  CZ  ARG A   2     -12.760   2.638  -4.279  1.00  3.73           C  
                            ATOM     36  NH1 ARG A   2     -13.766   2.542  -3.414  1.00  4.17           N  
                            ATOM     37  NH2 ARG A   2     -12.754   3.608  -5.178  1.00  4.44           N1+
                            ATOM     38  H   ARG A   2     -11.542  -0.398  -0.857  1.00  0.54           H  
                            ATOM     39  HA  ARG A   2      -9.720  -2.485  -1.218  1.00  0.51           H  
                            ATOM     40  HB2 ARG A   2     -10.341  -2.512  -3.469  1.00  0.59           H  
                            ATOM     41  HB3 ARG A   2     -11.781  -1.981  -2.620  1.00  0.59           H  
                            ATOM     42  HG2 ARG A   2      -9.834  -0.144  -4.137  1.00  1.27           H  
                            ATOM     43  HG3 ARG A   2     -11.314  -0.823  -4.766  1.00  1.27           H  
                            ATOM     44  HD2 ARG A   2     -12.645   0.270  -3.064  1.00  2.13           H  
                            ATOM     45  HD3 ARG A   2     -11.198   1.049  -2.387  1.00  2.13           H  
                            ATOM     46  HE  ARG A   2     -11.054   1.837  -4.971  1.00  2.80           H  
                            ATOM     47 HH11 ARG A   2     -13.880   1.706  -2.879  1.00  4.17           H  
                            ATOM     48 HH12 ARG A   2     -14.538   3.184  -3.493  1.00  4.17           H  
                            ATOM     49 HH21 ARG A   2     -12.003   3.688  -5.843  1.00  4.44           H  
                            ATOM     50 HH22 ARG A   2     -13.518   4.260  -5.234  1.00  4.44           H  
                            ATOM     51  N   TRP A   3      -8.400   0.373  -2.039  1.00  0.34           N  
                            ATOM     52  CA  TRP A   3      -7.143   0.996  -2.437  1.00  0.29           C  
                            ATOM     53  C   TRP A   3      -6.071   0.832  -1.361  1.00  0.22           C  
                            ATOM     54  O   TRP A   3      -4.887   0.732  -1.666  1.00  0.20           O  
                            ATOM     55  CB  TRP A   3      -7.345   2.472  -2.801  1.00  0.42           C  
                            ATOM     56  CG  TRP A   3      -7.972   3.301  -1.722  1.00  0.53           C  
                            ATOM     57  CD1 TRP A   3      -9.302   3.404  -1.438  1.00  0.60           C  
                            ATOM     58  CD2 TRP A   3      -7.297   4.167  -0.805  1.00  0.65           C  
                            ATOM     59  NE1 TRP A   3      -9.495   4.274  -0.395  1.00  0.75           N  
                            ATOM     60  CE2 TRP A   3      -8.279   4.755   0.013  1.00  0.79           C  
                            ATOM     61  CE3 TRP A   3      -5.956   4.498  -0.592  1.00  0.67           C  
                            ATOM     62  CZ2 TRP A   3      -7.962   5.658   1.026  1.00  0.95           C  
                            ATOM     63  CZ3 TRP A   3      -5.642   5.393   0.413  1.00  0.83           C  
                            ATOM     64  CH2 TRP A   3      -6.641   5.964   1.213  1.00  0.96           C  
                            ATOM     65  H   TRP A   3      -9.188   0.962  -1.858  1.00  0.34           H  
                            ATOM     66  HA  TRP A   3      -6.774   0.479  -3.290  1.00  0.29           H  
                            ATOM     67  HB2 TRP A   3      -6.379   2.905  -3.069  1.00  0.42           H  
                            ATOM     68  HB3 TRP A   3      -7.978   2.527  -3.688  1.00  0.42           H  
                            ATOM     69  HD1 TRP A   3     -10.084   2.958  -2.032  1.00  0.60           H  
                            ATOM     70  HE1 TRP A   3     -10.373   4.724  -0.186  1.00  0.75           H  
                            ATOM     71  HE3 TRP A   3      -5.183   4.078  -1.219  1.00  0.67           H  
                            ATOM     72  HZ2 TRP A   3      -8.728   6.130   1.622  1.00  0.95           H  
                            ATOM     73  HZ3 TRP A   3      -4.616   5.688   0.575  1.00  0.83           H  
                            ATOM     74  HH2 TRP A   3      -6.361   6.692   1.963  1.00  0.96           H  
                            ATOM     75  N   ARG A   4      -6.494   0.784  -0.101  1.00  0.25           N  
                            ATOM     76  CA  ARG A   4      -5.575   0.577   1.016  1.00  0.26           C  
                            ATOM     77  C   ARG A   4      -4.880  -0.775   0.910  1.00  0.20           C  
                            ATOM     78  O   ARG A   4      -3.756  -0.949   1.390  1.00  0.22           O  
                            ATOM     79  CB  ARG A   4      -6.299   0.715   2.354  1.00  0.39           C  
                            ATOM     80  CG  ARG A   4      -6.657   2.155   2.701  1.00  0.93           C  
                            ATOM     81  CD  ARG A   4      -5.414   3.012   2.937  1.00  0.78           C  
                            ATOM     82  NE  ARG A   4      -4.633   2.550   4.088  1.00  0.93           N  
                            ATOM     83  CZ  ARG A   4      -4.748   3.054   5.316  1.00  1.11           C  
                            ATOM     84  NH1 ARG A   4      -5.661   3.982   5.575  1.00  1.09           N  
                            ATOM     85  NH2 ARG A   4      -3.966   2.604   6.292  1.00  1.91           N1+
                            ATOM     86  H   ARG A   4      -7.482   0.844   0.080  1.00  0.25           H  
                            ATOM     87  HA  ARG A   4      -4.829   1.342   0.951  1.00  0.26           H  
                            ATOM     88  HB2 ARG A   4      -7.194   0.102   2.353  1.00  0.39           H  
                            ATOM     89  HB3 ARG A   4      -5.660   0.314   3.142  1.00  0.39           H  
                            ATOM     90  HG2 ARG A   4      -7.238   2.593   1.889  1.00  0.93           H  
                            ATOM     91  HG3 ARG A   4      -7.268   2.163   3.604  1.00  0.93           H  
                            ATOM     92  HD2 ARG A   4      -4.780   3.019   2.051  1.00  0.78           H  
                            ATOM     93  HD3 ARG A   4      -5.726   4.049   3.068  1.00  0.78           H  
                            ATOM     94  HE  ARG A   4      -3.901   1.883   3.914  1.00  0.93           H  
                            ATOM     95 HH11 ARG A   4      -5.743   4.374   6.497  1.00  1.09           H  
                            ATOM     96 HH12 ARG A   4      -6.194   4.361   4.816  1.00  1.09           H  
                            ATOM     97 HH21 ARG A   4      -4.071   2.965   7.224  1.00  1.91           H  
                            ATOM     98 HH22 ARG A   4      -3.297   1.878   6.115  1.00  1.91           H  
                            ATOM     99  N   ARG A   5      -5.560  -1.729   0.294  1.00  0.22           N  
                            ATOM    100  CA  ARG A   5      -4.985  -3.041   0.041  1.00  0.29           C  
                            ATOM    101  C   ARG A   5      -3.695  -2.905  -0.772  1.00  0.25           C  
                            ATOM    102  O   ARG A   5      -2.658  -3.463  -0.410  1.00  0.32           O  
                            ATOM    103  CB  ARG A   5      -5.992  -3.922  -0.703  1.00  0.37           C  
                            ATOM    104  CG  ARG A   5      -5.468  -5.303  -1.055  1.00  0.90           C  
                            ATOM    105  CD  ARG A   5      -6.516  -6.113  -1.809  1.00  0.89           C  
                            ATOM    106  NE  ARG A   5      -6.013  -7.430  -2.207  1.00  1.49           N  
                            ATOM    107  CZ  ARG A   5      -6.451  -8.108  -3.273  1.00  1.77           C  
                            ATOM    108  NH1 ARG A   5      -7.443  -7.625  -4.014  1.00  1.45           N  
                            ATOM    109  NH2 ARG A   5      -5.911  -9.279  -3.581  1.00  2.70           N1+
                            ATOM    110  H   ARG A   5      -6.478  -1.514  -0.065  1.00  0.22           H  
                            ATOM    111  HA  ARG A   5      -4.719  -3.507   0.990  1.00  0.29           H  
                            ATOM    112  HB2 ARG A   5      -6.903  -4.015  -0.108  1.00  0.37           H  
                            ATOM    113  HB3 ARG A   5      -6.230  -3.454  -1.650  1.00  0.37           H  
                            ATOM    114  HG2 ARG A   5      -4.584  -5.215  -1.688  1.00  0.90           H  
                            ATOM    115  HG3 ARG A   5      -5.196  -5.829  -0.138  1.00  0.90           H  
                            ATOM    116  HD2 ARG A   5      -7.395  -6.238  -1.172  1.00  0.89           H  
                            ATOM    117  HD3 ARG A   5      -6.805  -5.533  -2.689  1.00  0.89           H  
                            ATOM    118  HE  ARG A   5      -5.324  -7.862  -1.619  1.00  1.49           H  
                            ATOM    119 HH11 ARG A   5      -7.899  -6.777  -3.726  1.00  1.45           H  
                            ATOM    120 HH12 ARG A   5      -7.816  -8.149  -4.786  1.00  1.45           H  
                            ATOM    121 HH21 ARG A   5      -6.304  -9.813  -4.337  1.00  2.70           H  
                            ATOM    122 HH22 ARG A   5      -5.274  -9.721  -2.946  1.00  2.70           H  
                            ATOM    123  N   TRP A   6      -3.768  -2.157  -1.868  1.00  0.21           N  
                            ATOM    124  CA  TRP A   6      -2.602  -1.902  -2.710  1.00  0.27           C  
                            ATOM    125  C   TRP A   6      -1.654  -0.918  -2.024  1.00  0.22           C  
                            ATOM    126  O   TRP A   6      -0.439  -0.984  -2.197  1.00  0.26           O  
                            ATOM    127  CB  TRP A   6      -3.036  -1.339  -4.066  1.00  0.34           C  
                            ATOM    128  CG  TRP A   6      -4.150  -2.111  -4.710  1.00  0.35           C  
                            ATOM    129  CD1 TRP A   6      -4.188  -3.451  -4.958  1.00  0.43           C  
                            ATOM    130  CD2 TRP A   6      -5.388  -1.579  -5.190  1.00  0.34           C  
                            ATOM    131  NE1 TRP A   6      -5.372  -3.782  -5.564  1.00  0.49           N  
                            ATOM    132  CE2 TRP A   6      -6.126  -2.652  -5.718  1.00  0.43           C  
                            ATOM    133  CE3 TRP A   6      -5.943  -0.296  -5.226  1.00  0.32           C  
                            ATOM    134  CZ2 TRP A   6      -7.393  -2.482  -6.274  1.00  0.48           C  
                            ATOM    135  CZ3 TRP A   6      -7.199  -0.128  -5.776  1.00  0.37           C  
                            ATOM    136  CH2 TRP A   6      -7.913  -1.216  -6.294  1.00  0.44           C  
                            ATOM    137  H   TRP A   6      -4.650  -1.734  -2.123  1.00  0.21           H  
                            ATOM    138  HA  TRP A   6      -2.061  -2.823  -2.878  1.00  0.27           H  
                            ATOM    139  HB2 TRP A   6      -3.363  -0.307  -3.931  1.00  0.34           H  
                            ATOM    140  HB3 TRP A   6      -2.178  -1.329  -4.739  1.00  0.34           H  
                            ATOM    141  HD1 TRP A   6      -3.387  -4.137  -4.730  1.00  0.43           H  
                            ATOM    142  HE1 TRP A   6      -5.601  -4.689  -5.939  1.00  0.49           H  
                            ATOM    143  HE3 TRP A   6      -5.362   0.550  -4.888  1.00  0.32           H  
                            ATOM    144  HZ2 TRP A   6      -7.937  -3.315  -6.694  1.00  0.48           H  
                            ATOM    145  HZ3 TRP A   6      -7.615   0.866  -5.852  1.00  0.37           H  
                            ATOM    146  HH2 TRP A   6      -8.878  -1.050  -6.752  1.00  0.44           H  
                            ATOM    147  N   TRP A   7      -2.242  -0.005  -1.259  1.00  0.17           N  
                            ATOM    148  CA  TRP A   7      -1.507   1.011  -0.503  1.00  0.18           C  
                            ATOM    149  C   TRP A   7      -0.410   0.385   0.355  1.00  0.16           C  
                            ATOM    150  O   TRP A   7       0.756   0.770   0.262  1.00  0.19           O  
                            ATOM    151  CB  TRP A   7      -2.496   1.780   0.382  1.00  0.20           C  
                            ATOM    152  CG  TRP A   7      -1.906   2.906   1.171  1.00  0.34           C  
                            ATOM    153  CD1 TRP A   7      -1.329   2.832   2.406  1.00  0.44           C  
                            ATOM    154  CD2 TRP A   7      -1.870   4.282   0.790  1.00  0.51           C  
                            ATOM    155  NE1 TRP A   7      -0.927   4.081   2.809  1.00  0.62           N  
                            ATOM    156  CE2 TRP A   7      -1.251   4.986   1.836  1.00  0.65           C  
                            ATOM    157  CE3 TRP A   7      -2.299   4.988  -0.340  1.00  0.62           C  
                            ATOM    158  CZ2 TRP A   7      -1.054   6.362   1.790  1.00  0.85           C  
                            ATOM    159  CZ3 TRP A   7      -2.102   6.352  -0.385  1.00  0.81           C  
                            ATOM    160  CH2 TRP A   7      -1.485   7.028   0.676  1.00  0.91           C  
                            ATOM    161  H   TRP A   7      -3.251   0.065  -1.288  1.00  0.17           H  
                            ATOM    162  HA  TRP A   7      -1.035   1.708  -1.197  1.00  0.18           H  
                            ATOM    163  HB2 TRP A   7      -3.299   2.178  -0.236  1.00  0.20           H  
                            ATOM    164  HB3 TRP A   7      -2.866   1.120   1.141  1.00  0.20           H  
                            ATOM    165  HD1 TRP A   7      -1.185   1.915   2.964  1.00  0.44           H  
                            ATOM    166  HE1 TRP A   7      -0.451   4.289   3.675  1.00  0.62           H  
                            ATOM    167  HE3 TRP A   7      -2.762   4.471  -1.167  1.00  0.62           H  
                            ATOM    168  HZ2 TRP A   7      -0.586   6.889   2.607  1.00  0.85           H  
                            ATOM    169  HZ3 TRP A   7      -2.430   6.911  -1.252  1.00  0.81           H  
                            ATOM    170  HH2 TRP A   7      -1.353   8.100   0.611  1.00  0.91           H  
                            ATOM    171  N   ARG A   8      -0.776  -0.584   1.186  1.00  0.16           N  
                            ATOM    172  CA  ARG A   8       0.201  -1.226   2.052  1.00  0.22           C  
                            ATOM    173  C   ARG A   8       1.162  -2.101   1.239  1.00  0.20           C  
                            ATOM    174  O   ARG A   8       2.326  -2.261   1.612  1.00  0.23           O  
                            ATOM    175  CB  ARG A   8      -0.472  -2.025   3.178  1.00  0.36           C  
                            ATOM    176  CG  ARG A   8      -1.285  -3.223   2.723  1.00  0.93           C  
                            ATOM    177  CD  ARG A   8      -1.737  -4.047   3.917  1.00  1.11           C  
                            ATOM    178  NE  ARG A   8      -2.484  -5.243   3.530  1.00  1.71           N  
                            ATOM    179  CZ  ARG A   8      -2.072  -6.484   3.789  1.00  2.38           C  
                            ATOM    180  NH1 ARG A   8      -0.893  -6.678   4.366  1.00  2.43           N  
                            ATOM    181  NH2 ARG A   8      -2.829  -7.530   3.466  1.00  3.45           N1+
                            ATOM    182  H   ARG A   8      -1.759  -0.841   1.233  1.00  0.16           H  
                            ATOM    183  HA  ARG A   8       0.822  -0.455   2.513  1.00  0.22           H  
                            ATOM    184  HB2 ARG A   8       0.316  -2.372   3.849  1.00  0.36           H  
                            ATOM    185  HB3 ARG A   8      -1.119  -1.354   3.746  1.00  0.36           H  
                            ATOM    186  HG2 ARG A   8      -2.157  -2.888   2.163  1.00  0.93           H  
                            ATOM    187  HG3 ARG A   8      -0.680  -3.867   2.086  1.00  0.93           H  
                            ATOM    188  HD2 ARG A   8      -0.871  -4.269   4.539  1.00  1.11           H  
                            ATOM    189  HD3 ARG A   8      -2.398  -3.421   4.521  1.00  1.11           H  
                            ATOM    190  HE  ARG A   8      -3.378  -5.118   3.087  1.00  1.71           H  
                            ATOM    191 HH11 ARG A   8      -0.338  -5.890   4.633  1.00  2.43           H  
                            ATOM    192 HH12 ARG A   8      -0.581  -7.609   4.578  1.00  2.43           H  
                            ATOM    193 HH21 ARG A   8      -2.524  -8.458   3.704  1.00  3.45           H  
                            ATOM    194 HH22 ARG A   8      -3.762  -7.386   3.124  1.00  3.45           H  
                            ATOM    195  N   ARG A   9       0.672  -2.654   0.126  1.00  0.21           N  
                            ATOM    196  CA  ARG A   9       1.523  -3.398  -0.803  1.00  0.25           C  
                            ATOM    197  C   ARG A   9       2.660  -2.510  -1.293  1.00  0.21           C  
                            ATOM    198  O   ARG A   9       3.836  -2.859  -1.187  1.00  0.26           O  
                            ATOM    199  CB  ARG A   9       0.711  -3.878  -2.007  1.00  0.33           C  
                            ATOM    200  CG  ARG A   9      -0.107  -5.131  -1.771  1.00  1.21           C  
                            ATOM    201  CD  ARG A   9      -0.878  -5.498  -3.031  1.00  1.46           C  
                            ATOM    202  NE  ARG A   9      -1.415  -6.857  -2.991  1.00  2.08           N  
                            ATOM    203  CZ  ARG A   9      -1.818  -7.523  -4.072  1.00  2.69           C  
                            ATOM    204  NH1 ARG A   9      -1.816  -6.936  -5.262  1.00  2.94           N  
                            ATOM    205  NH2 ARG A   9      -2.224  -8.779  -3.967  1.00  3.48           N1+
                            ATOM    206  H   ARG A   9      -0.285  -2.452  -0.128  1.00  0.21           H  
                            ATOM    207  HA  ARG A   9       1.990  -4.246  -0.299  1.00  0.25           H  
                            ATOM    208  HB2 ARG A   9       0.065  -3.132  -2.415  1.00  0.33           H  
                            ATOM    209  HB3 ARG A   9       1.424  -4.120  -2.798  1.00  0.33           H  
                            ATOM    210  HG2 ARG A   9       0.578  -5.943  -1.521  1.00  1.21           H  
                            ATOM    211  HG3 ARG A   9      -0.792  -4.993  -0.938  1.00  1.21           H  
                            ATOM    212  HD2 ARG A   9      -1.699  -4.797  -3.166  1.00  1.46           H  
                            ATOM    213  HD3 ARG A   9      -0.194  -5.406  -3.878  1.00  1.46           H  
                            ATOM    214  HE  ARG A   9      -1.389  -7.340  -2.109  1.00  2.08           H  
                            ATOM    215 HH11 ARG A   9      -1.438  -6.009  -5.351  1.00  2.94           H  
                            ATOM    216 HH12 ARG A   9      -2.067  -7.445  -6.091  1.00  2.94           H  
                            ATOM    217 HH21 ARG A   9      -2.417  -9.296  -4.808  1.00  3.48           H  
                            ATOM    218 HH22 ARG A   9      -2.046  -9.285  -3.117  1.00  3.48           H  
                            ATOM    219  N   TRP A  10       2.282  -1.352  -1.820  1.00  0.18           N  
                            ATOM    220  CA  TRP A  10       3.237  -0.365  -2.301  1.00  0.18           C  
                            ATOM    221  C   TRP A  10       4.218   0.031  -1.205  1.00  0.15           C  
                            ATOM    222  O   TRP A  10       5.432   0.069  -1.431  1.00  0.15           O  
                            ATOM    223  CB  TRP A  10       2.483   0.870  -2.813  1.00  0.24           C  
                            ATOM    224  CG  TRP A  10       3.249   2.151  -2.673  1.00  0.27           C  
                            ATOM    225  CD1 TRP A  10       3.111   3.074  -1.678  1.00  0.32           C  
                            ATOM    226  CD2 TRP A  10       4.269   2.650  -3.543  1.00  0.33           C  
                            ATOM    227  NE1 TRP A  10       3.986   4.109  -1.869  1.00  0.39           N  
                            ATOM    228  CE2 TRP A  10       4.706   3.876  -3.010  1.00  0.39           C  
                            ATOM    229  CE3 TRP A  10       4.852   2.181  -4.715  1.00  0.39           C  
                            ATOM    230  CZ2 TRP A  10       5.703   4.636  -3.608  1.00  0.48           C  
                            ATOM    231  CZ3 TRP A  10       5.841   2.936  -5.313  1.00  0.49           C  
                            ATOM    232  CH2 TRP A  10       6.258   4.152  -4.758  1.00  0.53           C  
                            ATOM    233  H   TRP A  10       1.294  -1.141  -1.883  1.00  0.18           H  
                            ATOM    234  HA  TRP A  10       3.823  -0.781  -3.120  1.00  0.18           H  
                            ATOM    235  HB2 TRP A  10       2.220   0.718  -3.861  1.00  0.24           H  
                            ATOM    236  HB3 TRP A  10       1.551   0.987  -2.259  1.00  0.24           H  
                            ATOM    237  HD1 TRP A  10       2.390   2.992  -0.871  1.00  0.32           H  
                            ATOM    238  HE1 TRP A  10       3.967   4.965  -1.341  1.00  0.39           H  
                            ATOM    239  HE3 TRP A  10       4.529   1.247  -5.149  1.00  0.39           H  
                            ATOM    240  HZ2 TRP A  10       6.011   5.584  -3.206  1.00  0.48           H  
                            ATOM    241  HZ3 TRP A  10       6.299   2.587  -6.228  1.00  0.49           H  
                            ATOM    242  HH2 TRP A  10       7.035   4.717  -5.256  1.00  0.53           H  
                            ATOM    243  N   TRP A  11       3.682   0.316  -0.025  1.00  0.16           N  
                            ATOM    244  CA  TRP A  11       4.484   0.751   1.107  1.00  0.17           C  
                            ATOM    245  C   TRP A  11       5.551  -0.285   1.429  1.00  0.14           C  
                            ATOM    246  O   TRP A  11       6.747   0.022   1.423  1.00  0.18           O  
                            ATOM    247  CB  TRP A  11       3.576   0.968   2.323  1.00  0.23           C  
                            ATOM    248  CG  TRP A  11       4.078   1.996   3.288  1.00  0.36           C  
                            ATOM    249  CD1 TRP A  11       3.483   3.185   3.602  1.00  0.48           C  
                            ATOM    250  CD2 TRP A  11       5.278   1.931   4.066  1.00  0.43           C  
                            ATOM    251  NE1 TRP A  11       4.248   3.864   4.524  1.00  0.61           N  
                            ATOM    252  CE2 TRP A  11       5.353   3.109   4.829  1.00  0.58           C  
                            ATOM    253  CE3 TRP A  11       6.292   0.987   4.189  1.00  0.44           C  
                            ATOM    254  CZ2 TRP A  11       6.409   3.362   5.703  1.00  0.71           C  
                            ATOM    255  CZ3 TRP A  11       7.339   1.235   5.053  1.00  0.57           C  
                            ATOM    256  CH2 TRP A  11       7.391   2.411   5.801  1.00  0.69           C  
                            ATOM    257  H   TRP A  11       2.670   0.316   0.057  1.00  0.16           H  
                            ATOM    258  HA  TRP A  11       4.977   1.685   0.848  1.00  0.17           H  
                            ATOM    259  HB2 TRP A  11       2.608   1.324   1.972  1.00  0.23           H  
                            ATOM    260  HB3 TRP A  11       3.394   0.035   2.857  1.00  0.23           H  
                            ATOM    261  HD1 TRP A  11       2.538   3.524   3.192  1.00  0.48           H  
                            ATOM    262  HE1 TRP A  11       3.974   4.718   4.992  1.00  0.61           H  
                            ATOM    263  HE3 TRP A  11       6.257   0.029   3.716  1.00  0.44           H  
                            ATOM    264  HZ2 TRP A  11       6.458   4.274   6.280  1.00  0.71           H  
                            ATOM    265  HZ3 TRP A  11       8.200   0.655   5.015  1.00  0.57           H  
                            ATOM    266  HH2 TRP A  11       8.252   2.591   6.432  1.00  0.69           H  
                            ATOM    267  N   ARG A  12       5.106  -1.512   1.680  1.00  0.16           N  
                            ATOM    268  CA  ARG A  12       5.989  -2.595   2.092  1.00  0.22           C  
                            ATOM    269  C   ARG A  12       7.020  -2.912   1.004  1.00  0.21           C  
                            ATOM    270  O   ARG A  12       8.138  -3.340   1.291  1.00  0.27           O  
                            ATOM    271  CB  ARG A  12       5.150  -3.835   2.415  1.00  0.33           C  
                            ATOM    272  CG  ARG A  12       5.887  -4.902   3.207  1.00  1.49           C  
                            ATOM    273  CD  ARG A  12       6.456  -4.344   4.502  1.00  1.87           C  
                            ATOM    274  NE  ARG A  12       5.432  -3.709   5.336  1.00  2.29           N  
                            ATOM    275  CZ  ARG A  12       5.673  -2.688   6.153  1.00  2.74           C  
                            ATOM    276  NH1 ARG A  12       6.867  -2.119   6.173  1.00  3.00           N  
                            ATOM    277  NH2 ARG A  12       4.708  -2.206   6.925  1.00  3.27           N1+
                            ATOM    278  H   ARG A  12       4.109  -1.693   1.610  1.00  0.16           H  
                            ATOM    279  HA  ARG A  12       6.554  -2.241   2.951  1.00  0.22           H  
                            ATOM    280  HB2 ARG A  12       4.272  -3.530   2.985  1.00  0.33           H  
                            ATOM    281  HB3 ARG A  12       4.787  -4.275   1.484  1.00  0.33           H  
                            ATOM    282  HG2 ARG A  12       5.198  -5.715   3.437  1.00  1.49           H  
                            ATOM    283  HG3 ARG A  12       6.703  -5.305   2.606  1.00  1.49           H  
                            ATOM    284  HD2 ARG A  12       6.979  -5.125   5.056  1.00  1.87           H  
                            ATOM    285  HD3 ARG A  12       7.130  -3.638   4.176  1.00  1.87           H  
                            ATOM    286  HE  ARG A  12       4.514  -4.109   5.335  1.00  2.29           H  
                            ATOM    287 HH11 ARG A  12       7.100  -1.295   6.698  1.00  3.00           H  
                            ATOM    288 HH12 ARG A  12       7.602  -2.394   5.511  1.00  3.00           H  
                            ATOM    289 HH21 ARG A  12       3.810  -2.642   6.957  1.00  3.27           H  
                            ATOM    290 HH22 ARG A  12       4.925  -1.420   7.511  1.00  3.27           H  
                            ATOM    291  N   ARG A  13       6.627  -2.724  -0.247  1.00  0.18           N  
                            ATOM    292  CA  ARG A  13       7.524  -2.946  -1.375  1.00  0.22           C  
                            ATOM    293  C   ARG A  13       8.579  -1.852  -1.498  1.00  0.21           C  
                            ATOM    294  O   ARG A  13       9.779  -2.120  -1.400  1.00  0.25           O  
                            ATOM    295  CB  ARG A  13       6.737  -3.037  -2.685  1.00  0.28           C  
                            ATOM    296  CG  ARG A  13       6.249  -4.435  -3.025  1.00  0.93           C  
                            ATOM    297  CD  ARG A  13       7.415  -5.401  -3.194  1.00  1.38           C  
                            ATOM    298  NE  ARG A  13       8.414  -4.893  -4.138  1.00  1.86           N  
                            ATOM    299  CZ  ARG A  13       9.704  -5.232  -4.113  1.00  2.76           C  
                            ATOM    300  NH1 ARG A  13      10.144  -6.115  -3.229  1.00  3.47           N  
                            ATOM    301  NH2 ARG A  13      10.554  -4.702  -4.989  1.00  3.35           N1+
                            ATOM    302  H   ARG A  13       5.673  -2.427  -0.415  1.00  0.18           H  
                            ATOM    303  HA  ARG A  13       8.101  -3.849  -1.193  1.00  0.22           H  
                            ATOM    304  HB2 ARG A  13       5.880  -2.365  -2.644  1.00  0.28           H  
                            ATOM    305  HB3 ARG A  13       7.351  -2.671  -3.509  1.00  0.28           H  
                            ATOM    306  HG2 ARG A  13       5.591  -4.798  -2.234  1.00  0.93           H  
                            ATOM    307  HG3 ARG A  13       5.680  -4.393  -3.955  1.00  0.93           H  
                            ATOM    308  HD2 ARG A  13       7.855  -5.594  -2.216  1.00  1.38           H  
                            ATOM    309  HD3 ARG A  13       7.021  -6.349  -3.568  1.00  1.38           H  
                            ATOM    310  HE  ARG A  13       8.109  -4.240  -4.840  1.00  1.86           H  
                            ATOM    311 HH11 ARG A  13      11.121  -6.330  -3.169  1.00  3.47           H  
                            ATOM    312 HH12 ARG A  13       9.493  -6.534  -2.591  1.00  3.47           H  
                            ATOM    313 HH21 ARG A  13      10.238  -4.020  -5.654  1.00  3.35           H  
                            ATOM    314 HH22 ARG A  13      11.528  -4.941  -4.948  1.00  3.35           H  
                            ATOM    315  N   TRP A  14       8.130  -0.630  -1.743  1.00  0.20           N  
                            ATOM    316  CA  TRP A  14       9.034   0.456  -2.087  1.00  0.24           C  
                            ATOM    317  C   TRP A  14       9.805   0.986  -0.879  1.00  0.21           C  
                            ATOM    318  O   TRP A  14      11.036   1.020  -0.889  1.00  0.27           O  
                            ATOM    319  CB  TRP A  14       8.267   1.591  -2.760  1.00  0.31           C  
                            ATOM    320  CG  TRP A  14       9.160   2.550  -3.493  1.00  0.42           C  
                            ATOM    321  CD1 TRP A  14       9.546   2.468  -4.801  1.00  0.54           C  
                            ATOM    322  CD2 TRP A  14       9.776   3.735  -2.967  1.00  0.48           C  
                            ATOM    323  NE1 TRP A  14      10.374   3.517  -5.115  1.00  0.64           N  
                            ATOM    324  CE2 TRP A  14      10.523   4.312  -4.010  1.00  0.60           C  
                            ATOM    325  CE3 TRP A  14       9.768   4.364  -1.718  1.00  0.49           C  
                            ATOM    326  CZ2 TRP A  14      11.252   5.484  -3.842  1.00  0.70           C  
                            ATOM    327  CZ3 TRP A  14      10.491   5.529  -1.555  1.00  0.62           C  
                            ATOM    328  CH2 TRP A  14      11.222   6.077  -2.611  1.00  0.71           C  
                            ATOM    329  H   TRP A  14       7.131  -0.462  -1.735  1.00  0.20           H  
                            ATOM    330  HA  TRP A  14       9.780   0.086  -2.793  1.00  0.24           H  
                            ATOM    331  HB2 TRP A  14       7.605   1.148  -3.506  1.00  0.31           H  
                            ATOM    332  HB3 TRP A  14       7.619   2.112  -2.068  1.00  0.31           H  
                            ATOM    333  HD1 TRP A  14       9.246   1.681  -5.481  1.00  0.54           H  
                            ATOM    334  HE1 TRP A  14      10.812   3.658  -6.014  1.00  0.64           H  
                            ATOM    335  HE3 TRP A  14       9.363   3.862  -0.879  1.00  0.49           H  
                            ATOM    336  HZ2 TRP A  14      11.830   5.903  -4.652  1.00  0.70           H  
                            ATOM    337  HZ3 TRP A  14      10.553   5.992  -0.580  1.00  0.62           H  
                            ATOM    338  HH2 TRP A  14      11.802   6.975  -2.443  1.00  0.71           H  
                            ATOM    339  N   ARG A  15       9.081   1.413   0.150  1.00  0.20           N  
                            ATOM    340  CA  ARG A  15       9.699   2.114   1.270  1.00  0.22           C  
                            ATOM    341  C   ARG A  15      10.512   1.155   2.136  1.00  0.26           C  
                            ATOM    342  O   ARG A  15      11.738   1.272   2.198  1.00  0.44           O  
                            ATOM    343  CB  ARG A  15       8.637   2.836   2.105  1.00  0.41           C  
                            ATOM    344  CG  ARG A  15       8.130   4.129   1.479  1.00  0.57           C  
                            ATOM    345  CD  ARG A  15       7.175   3.873   0.321  1.00  0.40           C  
                            ATOM    346  NE  ARG A  15       6.826   5.109  -0.383  1.00  0.46           N  
                            ATOM    347  CZ  ARG A  15       5.970   6.019   0.083  1.00  0.82           C  
                            ATOM    348  NH1 ARG A  15       5.319   5.810   1.222  1.00  1.35           N  
                            ATOM    349  NH2 ARG A  15       5.754   7.133  -0.602  1.00  0.88           N1+
                            ATOM    350  H   ARG A  15       8.103   1.151   0.194  1.00  0.20           H  
                            ATOM    351  HA  ARG A  15      10.432   2.833   0.899  1.00  0.22           H  
                            ATOM    352  HB2 ARG A  15       7.797   2.176   2.309  1.00  0.41           H  
                            ATOM    353  HB3 ARG A  15       9.087   3.102   3.064  1.00  0.41           H  
                            ATOM    354  HG2 ARG A  15       7.605   4.691   2.252  1.00  0.57           H  
                            ATOM    355  HG3 ARG A  15       8.979   4.730   1.153  1.00  0.57           H  
                            ATOM    356  HD2 ARG A  15       7.577   3.176  -0.389  1.00  0.40           H  
                            ATOM    357  HD3 ARG A  15       6.273   3.403   0.713  1.00  0.40           H  
                            ATOM    358  HE  ARG A  15       7.302   5.285  -1.257  1.00  0.46           H  
                            ATOM    359 HH11 ARG A  15       5.504   4.964   1.737  1.00  1.35           H  
                            ATOM    360 HH12 ARG A  15       4.697   6.504   1.592  1.00  1.35           H  
                            ATOM    361 HH21 ARG A  15       5.128   7.836  -0.251  1.00  0.88           H  
                            ATOM    362 HH22 ARG A  15       6.282   7.316  -1.439  1.00  0.88           H  
                            ATOM    363  N   ARG A  16       9.812   0.212   2.780  1.00  0.40           N  
                            ATOM    364  CA  ARG A  16      10.426  -0.903   3.499  1.00  0.55           C  
                            ATOM    365  C   ARG A  16       9.445  -1.514   4.487  1.00  1.46           C  
                            ATOM    366  O   ARG A  16       8.808  -2.523   4.143  1.00  2.20           O  
                            ATOM    367  CB  ARG A  16      11.692  -0.520   4.256  1.00  1.14           C  
                            ATOM    368  CG  ARG A  16      12.419  -1.746   4.749  1.00  2.07           C  
                            ATOM    369  CD  ARG A  16      12.742  -2.670   3.586  1.00  2.76           C  
                            ATOM    370  NE  ARG A  16      13.005  -4.042   4.015  1.00  3.02           N  
                            ATOM    371  CZ  ARG A  16      12.078  -5.008   4.019  1.00  3.81           C  
                            ATOM    372  NH1 ARG A  16      10.808  -4.734   3.721  1.00  4.43           N  
                            ATOM    373  NH2 ARG A  16      12.421  -6.246   4.337  1.00  4.37           N1+
                            ATOM    374  OXT ARG A  16       9.332  -0.991   5.612  1.00  2.24           O1-
                            ATOM    375  H   ARG A  16       8.812   0.193   2.633  1.00  0.40           H  
                            ATOM    376  HA  ARG A  16      10.560  -1.633   2.719  1.00  0.55           H  
                            ATOM    377  HB2 ARG A  16      12.488  -0.095   3.669  1.00  1.14           H  
                            ATOM    378  HB3 ARG A  16      11.476   0.159   5.083  1.00  1.14           H  
                            ATOM    379  HG2 ARG A  16      13.343  -1.453   5.250  1.00  2.07           H  
                            ATOM    380  HG3 ARG A  16      11.795  -2.270   5.474  1.00  2.07           H  
                            ATOM    381  HD2 ARG A  16      12.014  -2.718   2.791  1.00  2.76           H  
                            ATOM    382  HD3 ARG A  16      13.646  -2.282   3.113  1.00  2.76           H  
                            ATOM    383  HE  ARG A  16      13.950  -4.277   4.260  1.00  3.02           H  
                            ATOM    384 HH11 ARG A  16      10.475  -3.776   3.617  1.00  4.43           H  
                            ATOM    385 HH12 ARG A  16      10.108  -5.445   3.689  1.00  4.43           H  
                            ATOM    386 HH21 ARG A  16      11.714  -6.956   4.379  1.00  4.37           H  
                            ATOM    387 HH22 ARG A  16      13.375  -6.462   4.560  1.00  4.37           H  
                            TER     388      ARG A  16 
                            END

        in: 
            ajf: init/ajf
            nproc: nproc
        out:
            - log
            - cpf
            - pdb



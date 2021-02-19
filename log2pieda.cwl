#!/usr/bin/env cwltool
cwlVersion: v1.0
class: CommandLineTool
baseCommand: awk
arguments:
  - >
    BEGIN {
      err = 1; 
      lig = $(inputs.lig_id); 
      begin = $(inputs.begin_id); 
      end = $(inputs.end_id); 
      OFS = ","}
    function between(obj, lhs, rhs) { return (lhs <= obj && obj <= rhs) }
    /## PIEDA/ { err = 0; print "i", "j", "es", "ex", "ct_mix", "di", "q"; next } 
    err { next }
    lig == $2 && between($1, begin, end) { toRead = 1 }
    lig == $1 && between($2, begin, end) { toRead = 1 }
    toRead { $1 = $1;  print; toRead  = 0 }
    /##/ { exit err }
    END { exit err }
stdout: $(inputs.outfile)
inputs:
  infile:
    type: File
    inputBinding:
      position: 1
    streamable: true
  lig_id:
    type: int
  begin_id:
    type: int
  end_id:
    type: int
  outfile:
    type: string
    default: log.csv
outputs:
  outfile:
    type: stdout



cwlVersion: v1.0

class: CommandLineTool
baseCommand: [ '/bin/bash', '&&' , 'source', '/usr/local/bin/set_ld_library_path.sh', '&&', 'delly', 'call' ] # workaround for singularity <=3.3.0
id: delly_call

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement: 
    dockerPull: mskcc/delly:v0.8.1
  ResourceRequirement:
    ramMin: 4000
    coresMin: 1

inputs:
  svtype:
    type: string
    inputBinding:
      prefix: --svtype

  tumor_sample_name:
    type: string

  normal_sample_name:
    type: string

  genome:
    type: File
    inputBinding:
      prefix: --genome
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - .fai
      - ^.dict 
  
  bam_tumor:
    type: File
    inputBinding:
      position: 1
    secondaryFiles:
      - ^.bai

  bam_normal:
    type: File
    inputBinding:
      position: 2
    secondaryFiles:
      - ^.bai

  exclude:
    type: File
    inputBinding:
      prefix: --exclude

  outfile:
    type: string
    inputBinding:
      prefix: --outfile

outputs:
  output:
    type: File?
    secondaryFiles:
      - .csi
    outputBinding:
      glob: |
        ${
          if(inputs.outfile)
            return inputs.outfile;
          return null
        
        }

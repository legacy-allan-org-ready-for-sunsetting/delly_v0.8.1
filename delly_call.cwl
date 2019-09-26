cwlVersion: v1.0

class: CommandLineTool
baseCommand: [ delly, call ]
id: delly_call

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement: 
    dockerPull: cmopipeline/delly:v0.8.1
  ResourceRequirement:
    ramMin: 4000
    coresMin: 1

inputs:
  svtype:
    type: string
    inputBinding:
      prefix: --svtype

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
    outputBinding:
      glob: |
        ${
          if(inputs.outfile)
            return inputs.outfile;
          return null
        
        }

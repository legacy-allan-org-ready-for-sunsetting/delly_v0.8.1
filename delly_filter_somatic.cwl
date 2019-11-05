cwlVersion: v1.0

class: CommandLineTool
baseCommand: [ '/bin/bash', '&&' , 'source', '/usr/local/bin/set_ld_library_path.sh', '&&', 'delly', 'filter' ] # workaround for singularity <= 3.3.0
id: delly_filter

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement: 
    dockerPull: cmopipeline/delly:v0.8.1
  ResourceRequirement:
    ramMin: 4000
    coresMin: 1

arguments:
  - position: 1
    valueFrom: somatic
    prefix: --filter

inputs:
  call_bcf_file:
    type: File
    inputBinding:
      position: 2
    secondaryFiles:
      - .csi

  samples: 
    type: File
    inputBinding:
      prefix: --samples

  outfile:
    type: string
    inputBinding:
      prefix: --outfile

outputs:
  output:
    type: File
    secondaryFiles:
      - .csi
    outputBinding:
      glob: |
        ${
          if(inputs.outfile)
            return inputs.outfile;
          return null
        }

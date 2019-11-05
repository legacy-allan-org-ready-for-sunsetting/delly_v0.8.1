export LD_LIBRARY_PATH=/usr/local/bin/htslib-1.9/

filterType=$1
samples=$2
inputFile=$3
outfile=$4

delly filter \
  --filter $filterType \
  --samples $samples \
  --outfile $outfile \
  $inputFile

#!/bin/bash

echo "Starting.."

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

echo "logfile; Sample:$1" > $1.log

virus=$3

#if [ $4 != "skip" ] 
  #then 
bash getReads.sh $1 $2 ;
#echo "Getting MPXV specific reads.."

rm $1.reads $1_blast.txt $1_MP.fastq $1.fasta ;
  #fi 

#echo -e "Found $(wc -l $1.reads) MPXV specific reads"

#cleaning 1

echo "Map to reference.."

echo $virus

if [ $virus == "MPXV" ]
  then bash map2MP.sh $1
  fi
if [ $virus == "VV" ]
  then bash map2VV.sh $1
  fi
if [ $virus == "IIA" ]
  then bash mapCladeIIA.sh $1
  fi
if [ $virus == "I" ]
  then bash mapCladeI.sh $1
  fi

echo "Sample_ACCESSION	Genome_positions	Depth" > $1.depth


bash 2consensus.sh $1

#cleaning 2


bash $SCRIPT_DIR/map2FA.sh $(echo $1)

#rm $1.sam $1_tr.fastq $1_q10_07_m10.qual.txt #$1_Q.sam

echo "Generate coverage plot.."
echo "Sample AC Reads Median_Depth"
for fasta in $(ls $1*.fst);
 do prefix=$(echo $fasta | cut -f1 -d ".");
 AC=$(grep ">" $fasta | cut -f2 -d ">");
 echo -n $prefix" "; 
 echo -n $AC" "$(( $(grep $AC $prefix.sam | wc -l ) - 2 ));
 
 echo "Sample_ACCESSION	Genome_positions	Depth" > $AC.depth; 
 grep $AC $1.depth >> $AC.depth ;
 coverage.r $AC.depth;
 mv Rplots.pdf $AC.pdf ;
 echo " " $(python $SCRIPT_DIR/depth.py $AC.depth) ;done

#coverage.r $1.depth

#calcul depth

#cleaning 3

rm $1*.fst

#same on the remaping 

echo "Generate coverage plot.."

for ac in $(grep ">" $(echo $1)_RE.fasta | cut -f2 -d ">");
  do echo -n $(echo $1)" "; 
  echo -n $ac" "$(( $(grep $ac $(echo $1)_RE.sam | wc -l ) - 2 ));
 
  echo "Sample_ACCESSION	Genome_positions	Depth" > $ac.depth; 
  grep $ac $1_RE.depth >> $ac.depth ;
  coverage.r $ac.depth;
  mv Rplots.pdf $(echo $ac)_RE.pdf ;
  echo -n " " ; echo " " $(python $SCRIPT_DIR/depth.py $ac.depth) ;done


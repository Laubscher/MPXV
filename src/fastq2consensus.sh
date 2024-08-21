#!/bin/bash

echo "Starting.."

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

echo "logfile; Sample:$1" > $1.log

virus=$3

#if [ $4 != "skip" ] 
  #then 
bash $SCRIPT_DIR/getReads.sh $1 $2 ;
#echo "Getting MPXV specific reads.."

rm $1.reads $1_blast.txt $1_MP.fastq $1.fasta ;
  #fi 

#echo -e "Found $(wc -l $1.reads) MPXV specific reads"

#cleaning 1

echo "Map to reference.."

echo $virus

if [ $virus == "MPXV" ]
  then bash $SCRIPT_DIR/map2MP.sh $1
  fi
if [ $virus == "VV" ]
  then bash $SCRIPT_DIR/map2VV.sh $1
  fi
if [ $virus == "IIA" ]
  then bash $SCRIPT_DIR/mapCladeIIA.sh $1
  fi
if [ $virus == "IB" ]
  then bash $SCRIPT_DIR/mapCladeIB.sh $1
  fi
if [ $virus == "ALL" ]
  then bash $SCRIPT_DIR/map2ALL.sh $1

  fi


echo "Sample_ACCESSION	Genome_positions	Depth" > $1.depth


bash $SCRIPT_DIR/2consensus.sh $1

#cleaning 2

rm $1.sam $1.sorted.bam test3.sorted.bam.bai
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
 Rscript $SCRIPT_DIR/coverage.r $AC.depth;
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
  Rscript $SCRIPT_DIR/coverage.r $ac.depth;
  mv Rplots.pdf $(echo $ac)_RE.pdf ;
  echo -n " " ; echo " " $(python $SCRIPT_DIR/depth.py $ac.depth) ;done

#cleaning 4
rm $1*.AC $1.fa $1*.fasta $1_tr.fastq $1*qual.txt $1*_RE.sam
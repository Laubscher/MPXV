from collections import Counter, OrderedDict
import pysam
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import sys

#argv [1] = prfix, [2] = ref, [3] = len 

bam_fname=str(sys.argv[1])+".sorted.bam"
ac_threshold=10
af_threshold=0.55
out_fname=str(sys.argv[1])+".fasta"

consensus = OrderedDict()
#for record in SeqIO.parse(ref_fname, "fasta"):
#sys.argv[2]
AClist=[]
fichierAC=open(str(sys.argv[2]), "r")
for ac in fichierAC:
              AClist.append(ac.rstrip())
fichierAC.close()

for i in AClist:
  consensus[i] = ["N"] * int(sys.argv[3])     # on peut avoir une entrée par ref ici           

with pysam.AlignmentFile(bam_fname, "rb") as bam:
        allele_counter = Counter()
        for pileup_column in bam.pileup():
            ref = pileup_column.reference_name
            pos = pileup_column.reference_pos
            assert consensus[ref][pos] == "N"

            allele_counter.clear()
            for pileup_read in pileup_column.pileups:
                if pileup_read.is_del:
                    pass #allele = "-" # on part du principe qu'il n'y apas de déletion 
                else:
                    allele = pileup_read.alignment.query_sequence[pileup_read.query_position]
                    allele_counter[allele] += 1

            max_allele = "N"
            max_count, total_count = 0, 0
            for allele, count in allele_counter.items():
                if count > max_count:
                    max_count = count
                    max_allele = allele
                total_count += count

            assert max_allele in "ACGTN"
            if (max_count >= ac_threshold and max_count / total_count >= af_threshold):
                consensus[ref][pos] = max_allele

records = []
for ref, seq in consensus.items():
        records.append(SeqRecord(Seq("".join(seq)), id=ref, description=""))

SeqIO.write(records, out_fname, "fasta")

rule star_align:
    input:
        fastq="data/{sample}.fastq.gz"
    output:
        bam="results/aligned/{sample}Aligned.sortedByCoord.out.bam"
    threads: 2  
    resources:
        mem_mb=4000 
    shell:
        """
        STAR --runThreadN {threads} \
             --genomeDir {config[star_index]} \
             --readFilesIn {input.fastq} \
             --readFilesCommand zcat \
             --outFileNamePrefix results/aligned/{wildcards.sample} \
             --outSAMtype BAM SortedByCoordinate
        """


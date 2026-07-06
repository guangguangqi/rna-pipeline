rule star_align:
    input:
        fastq="data/{sample}.fastq.gz"
    output:
        bam="results/aligned/{sample}Aligned.sortedByCoord.out.bam"
    threads: 4  # Balanced for local laptop execution
    resources:
        mem_mb=16000 
    shell:
        """
        STAR --runThreadN {threads} \
             --genomeDir {config[star_index]} \
             --readFilesIn {input.fastq} \
             --readFilesCommand zcat \
             --outFileNamePrefix results/aligned/{sample} \
             --outSAMtype BAM SortedByCoordinate
        """


rule star_align:
    input:
        fastq="data/{sample}.fastq.gz"
    output:
        bam="results/aligned/{sample}Aligned.sortedByCoord.out.bam"
    threads: 2  # Matches Minikube allotment
    resources:
        mem_mb=4000 # Reduced to 4GB so it fits cleanly inside your 6GB cluster limit
    shell:
        """
        STAR --runThreadN {threads} \
             --genomeDir {config[star_index]} \
             --readFilesIn {input.fastq} \
             --readFilesCommand zcat \
             --outFileNamePrefix results/aligned/{sample} \
             --outSAMtype BAM SortedByCoordinate
        """


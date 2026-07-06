rule fastqc:
    input:
        "data/{sample}.fastq.gz"
    output:
        html="results/qc/{sample}_fastqc.html",
        zip="results/qc/{sample}_fastqc.zip"
    threads: 2
    resources:
        mem_mb=2000
    shell:
        "fastqc {input} --outdir results/qc/"


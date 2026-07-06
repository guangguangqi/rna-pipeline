configfile: "config/config.yaml"

SAMPLES = config["samples"]

rule all:
    input:
        expand("results/qc/{sample}_fastqc.html", sample=SAMPLES),
        expand("results/aligned/{sample}Aligned.sortedByCoord.out.bam", sample=SAMPLES)

# Include your separated workflow files
include: "rules/qc.smk"
include: "rules/align.smk"


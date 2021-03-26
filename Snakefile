rule plotype_caller:
    input:
        cram="/LAB- DATA/BiRD/shares/ITX/u1087/CNG/ccc/store/cont007/fg0156/fg0156/analyse/projet_MITRALSEQ_633/ANALYSE/ANALYSE_M633_C00097B_HYH2FDSXX_1-2-3-4_hs37d5/MAPPING_C00097B/reliable.realign/{sample}.cram",
        ref="/LAB-DATA/BiRD/resources/species/human/cng.fr/hs37d5/hs37d5_all_chr.fasta"
    output:
        gvcf="/SCRATCH-BIRD/users/karastoo/calls/{sample}.g.vcf",
    log:
        "logs/gatk/haplotypecaller/{sample}.log"
    params:
        extra="",  # optional
        java_opts="", # optional
    shell:
        "gatk --java-options '{java_opts}' HaplotypeCaller {extra} "
        "-R {snakemake.input.ref} {crams} "
        "-ERC GVCF {bam_output} "
        "-O {snakemake.output.gvcf} {known} {log}"

rule all:
    input:  
        expand(gvcf="/SCRATCH-BIRD/users/karastoo/calls/{sample}.g.vcf", sample=samples.split('  '))

rule haplotype_caller:
    input:
        cram="/LAB- DATA/BiRD/shares/ITX/u1087/CNG/ccc/store/cont007/fg0156/fg0156/analyse/projet_MITRALSEQ_633/ANALYSE/ANALYSE_M633_C00097B_HYH2FDSXX_1-2-3-4_hs37d5/{sample}.cram",
        ref="/LAB-DATA/BiRD/resources/species/human/cng.fr/hs37d5/hs37d5_all_chr.fasta"
    output:
        gvcf="/SCRATCH-BIRD/users/karastoo/calls/{sample}.g.vcf"
    shell:
        "gatk --java-options HaplotypeCaller "
        "-R {input.ref} "
        "-I {input.cram}"
        "-ERC GVCF {bam_output} "
        "-O {output.gvcf} "

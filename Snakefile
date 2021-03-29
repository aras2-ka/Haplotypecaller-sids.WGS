SAMPLES = {	
"C00097B":"/LAB-DATA/BiRD/shares/ITX/u1087/CNG/ccc/store/cont007/fg0156/fg0156/analyse/projet_MITRALSEQ_633/ANALYSE/ANALYSE_M633_C00097B_HYH2FDSXX_1-2-3-4_hs37d5/MAPPING_C00097B/reliable.realign/M633_DA_C00097B_HYH2FDSXX_hs37d5_MERGE_PE_1-2-3-4.reliable.realign.cram",
"C00097D":"/LAB-DATA/BiRD/shares/ITX/u1087/CNG/ccc/store/cont007/fg0156/fg0156/analyse/projet_MITRALSEQ_633/ANALYSE/ANALYSE_M633_C00097D_HYH2FDSXX_1-2-3-4_hs37d5/MAPPING_C00097D/reliable.realign/M633_DA_C00097D_HYH2FDSXX_hs37d5_MERGE_PE_1-2-3-4.reliable.realign.cram",
"C00097C":"/LAB-DATA/BiRD/shares/ITX/u1087/CNG/ccc/store/cont007/fg0156/fg0156/analyse/projet_MITRALSEQ_633/ANALYSE/ANALYSE_M633_C00097C_HYH2FDSXX_1-2-3-4_hs37d5/MAPPING_C00097C/reliable.realign/M633_DA_C00097C_HYH2FDSXX_hs37d5_MERGE_PE_1-2-3-4.reliable.realign.cram",
"C000979":"/LAB-DATA/BiRD/shares/ITX/u1087/CNG/ccc/store/cont007/fg0156/fg0156/analyse/projet_MITRALSEQ_633/ANALYSE/ANALYSE_M633_C000979_HYH2FDSXX_1-2-3-4_hs37d5/MAPPING_C000979/reliable.realign/M633_DA_C000979_HYH2FDSXX_hs37d5_MERGE_PE_1-2-3-4.reliable.realign.cram",
"C00097A":"/LAB-DATA/BiRD/shares/ITX/u1087/CNG/ccc/store/cont007/fg0156/fg0156/analyse/projet_MITRALSEQ_633/ANALYSE/ANALYSE_M633_C00097A_HYH2FDSXX_1-2-3-4_hs37d5/MAPPING_C00097A/reliable.realign/M633_DA_C00097A_HYH2FDSXX_hs37d5_MERGE_PE_1-2-3-4.reliable.realign.cram"
}

print(SAMPLES.keys())

rule all:
    input: expand("/SCRATCH-BIRD/users/karastoo/calls/{sample}.g.vcf", sample = SAMPLES.keys())

rule haplotype_caller:
    input:
        cram=lambda wildcards: SAMPLES[wildcards.sample],
        ref="/LAB-DATA/BiRD/resources/species/human/cng.fr/hs37d5/hs37d5_all_chr.fasta"
    output:
        gvcf="/SCRATCH-BIRD/users/karastoo/calls/{sample}.g.vcf"
    params:
        tmpdir="/SCRATCH-BIRD/users/karastoo/calls/"
    shell:	"""
		gatk --java-options "-Djava.io.tmpdir={params.tmpdir} -XX:ParallelGCThreads=5 -Xmx10g" HaplotypeCaller -R {input.ref} -I {input.cram} -O {output.gvcf} -ERC GVCF
		"""

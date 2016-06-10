INDEXVCF_TARGETS = `{find -L data/ -name '*.vcf' \
	| sed -e 's#^data/#results/indexvcf/#g' \
		-e 's#$#.gz.tbi#g'}

indexvcf:V:	$INDEXVCF_TARGETS


results/indexvcf/%.vcf.gz.tbi:		results/indexvcf/%.vcf.gz
	mkdir -p `dirname $target`
	tabix -p vcf results/indexvcf/$stem.vcf.gz

results/indexvcf/%.vcf.gz:		data/%.vcf
	mkdir -p `dirname $target`
	cp data/$stem.vcf results/indexvcf/$stem.vcf
	bgzip results/indexvcf/$stem.vcf

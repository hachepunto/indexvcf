INDEXVCF_TARGETS = `{./targets}

indexvcf:EV:	$INDEXVCF_TARGETS

results/indexvcf/%.sort.vcf.gz.tbi \
results/indexvcf/%.sort.vcf.gz:D:	results/indexvcf/%.vcf.gz
	mkdir -p `dirname $target`
	vcf-sort results/indexvcf/$stem.vcf.gz \
	>  'results/indexvcf/'$stem'.sort.vcf' \
	&& bgzip 'results/indexvcf/'$stem'.sort.vcf' \
	&& bcftools index -t 'results/indexvcf/'$stem'.sort.vcf.gz'

'results/indexvcf/%.vcf.gz':D:		'data/%.vcf.gz'
	DIR=`dirname $target`
	mkdir -p "$DIR"
	cp $prereq "$DIR"
	test -f $target || bgzip 'results/indexvcf/'$stem'.vcf'

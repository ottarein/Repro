process WGET {
    publishDir "results"
    container 'evolbioinfo/ubuntu:v24.04'

    output:
    path "ref.nw.gz"

    script:
    """
    wget https://booster.pasteur.fr/static/files/primates/ref.nw.gz
    """
}

process TREE {
    publishDir "results"
    container 'evolbioinfo/gotree:v0.4.1a'

    input:
    path newick

    output:
    path "tips.txt"

    script:
    """
    gotree stats tips -i ${newick} > tips.txt
    """
}

workflow {
    TREE(WGET())
    TREE.out.splitCsv(sep: '\t', header: true).view()
    TREE.out.splitCsv(sep: '\t', header: true).count().view()

}
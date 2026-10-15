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
    container 'evolbioinfo/ubuntu:v24.04'

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
    archive = WGET()
    TREE(archive.out)
}
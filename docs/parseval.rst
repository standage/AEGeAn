ParsEval
========

Introduction
------------

**ParsEval** is a program for comparing two sets of gene annotations for the
same sequence. The most common use cases for ParsEval are as follows.

* You are annotating a newly assembled genome. The optimal parameter settings
  for annotation are not clear initially, so you do some exploratory data
  analysis and try several different parameter settings. You can use ParsEval to
  identify the similarities and differences between the different annotations
  you have produced.

* You are doing a genome-wide analysis of genes in your favorite organism. There
  is a gene annotation available from the consortium that sequenced and
  assembled the genome, but there is a different annotation available at NCBI.
  Again, ParsEval is the best way to compare these two annotations to quickly
  identify their similarities and differences.

Input
-----

Input for ParsEval is two sets of annotations in GFF3 format. ParsEval uses the
GenomeTools GFF3 parser, which strictly enforces syntax rules laid out in the
`GFF3 specification <http://sequenceontology.org/resources/gff3.html>`_.
ParsEval itself does some additional checks on the data to make sure valid
comparisons are possible.

* Any features not directly related to protein-coding genes are ignored.

* ParsEval will infer features implicitly encoded in the data. For example, if a
  gene annotation declares 6 exon features but no intron features, ParsEval will
  infer the 5 corresponding intron features from the exon boundaries. However,
  if ParsEval sees any intron features in a gene model it will assume all
  introns are declared explicitly. Violations of that assumption will likely
  elicit a program error.

  ParsEval is pretty flexible in handling various common conventions for
  encoding gene structure: exons + start/stop codons, exons + CDS, CDS + UTRs,
  etc. Any subset of features that completely captures the gene's exon/intron
  structure, CDS(s), and UTRs should be handled correctly.

* ParsEval requires that gene isoforms be encoded using the feature type `mRNA`
  (as opposed to `transcript`, `primary_transcript`, or other valid SO terms).
  For `mRNA` features lacking an explicitly declared `gene` parent, ParsEval
  will create one. Note, however, that ParsEval will treat all such transcripts
  as belonging to separate distinct genes, which will erroneously inflate
  summary statistics reported by ParsEval.

See :ref:`GFF3ValidationDocs` for instructions on validating ParsEval input
files.

Output
------

ParsEval output includes a variety of similarity statistics that measure the
agreement between the two annotations. Our use of *agreement* here instead of
*accuracy* is intentional: except in a very few rare cases, you will not be
comparing a prediction to a true high-quality "gold standard." It is much more
common to compare two annotation sets whose relative quality is unknown.
ParsEval uses the terms *reference* and *prediction* only to distinguish the two
sets: it makes no assumptions as to their relative quality.

Similarity statistics are currently reported at two levels of granularity.
First, a report for each individual locus shows the similarity of the
annotations at that locus, with the option to also include an embedded graphical
representation as well (if using HTML output mode). Second, the similarity
statistics are aggregated over the entire data and presented in a single summary
report.

Running ParsEval
----------------

For a description of ParsEval's command-line interface, run the following
command (after AEGeAn has been installed).

.. code-block:: bash

    parseval --help

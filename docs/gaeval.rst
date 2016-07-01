GAEVAL
======

Introduction
------------

**GAEVAL** is a program for computing coverage and integrity scores for gene
models using transcript alignments. The integrity score is a value between 0 and
1 that indicates the level of agreement between the gene model and any related
transcript alignments, with 0 corresponding to no transcript support and 1
corresponding to complete transcript support.

The GAEVAL program is based on a much more comprehensive `Perl module of the
same name`_ that has been in production at `PlantGDB`_ for many years, but whose
development is no longer supported.

.. _`Perl module of the same name`: http://www.plantgdb.org/GAEVAL/docs/index.html
.. _`PlantGDB`: http://www.plantgdb.org/

Input
-----

Input for GAEVAL is two GFF3 files, one containing gene predictions/annotations
and one containing transcript alignments. Although the GFF3 Specification
explicitly supports several similar encoding conventions for alignment features,
only one is supported by GAEVAL, as shown below.

.. code-block:: text

    ctg123 . cDNA_match 1050  1500  5.8e-42  +  . ID=match00001;Target=cdna0123 12 462
    ctg123 . cDNA_match 5000  5500  8.1e-43  +  . ID=match00001;Target=cdna0123 463 963
    ctg123 . cDNA_match 7000  9000  1.4e-40  +  . ID=match00001;Target=cdna0123 964 2964

GAEVAL will accept alignments with types `cDNA_match`, `EST_match`, and the
generic `nucleotide_match`, depending on the source of the data.

The `Target` and `Gap` attributes are not disallowed by GAEVAL, but they are not
interpreted by GAEVAL either. Gapped or spliced alignments must be encoded as
multifeatures, with each segment of the alignment on its own distinct line and
all segments of a single alignment sharing the same `ID` attribute.

Output
------

GAEVAL computes coverage and integrity scores for each `mRNA` feature in the
gene prediction input. The output will be identical to the input, except that
each `mRNA` feature will have two new attribtues: `gaeval_coverage` and
`gaeval_integrity`.

Configuration
-------------

The calculation of coverage is straightforward: GAEVAL computes the percentage
of nucleotides in exons that have coverage from one or more transcript
alignments.

The calculation of integrity is a bit more complex. The integrity score for each
gene prediction is a composite of 4 values.

* :math:`A`: the percentage of introns confirmed by an alignment gap; for
  single-exon gene predictions lacking introns, :math:`A` represents the ratio
  of the observed CDS length to the expected CDS length (with a maximum of 1.0)
* :math:`B`: the exon coverage
* :math:`\Gamma`: the ratio of the observed 5' UTR length to the expected 5' UTR
  length (with a maximum of 1.0)
* :math:`E`: the ratio of the observed 3' UTR length to the expected 3' UTR
  length (with a maximum of 1.0)

A weight is applied to each of these 4 values, and the final integrity score
:math:`\Phi` is computed as follows.

.. math::

   \Phi = \alpha A + \beta B + \gamma \Gamma + \epsilon E

The sum of the weights must be 1.0, and their default values are as follows.

* :math:`\alpha = 0.6`
* :math:`\beta = 0.3`
* :math:`\gamma = 0.05`
* :math:`\epsilon = 0.05`

Expected lengths for UTRs and CDSs should be determined empirically. The
original GAEVAL tool calculated these values as the length achieved by 95% of
the evaluated features.

Running GAEVAL
--------------

For a complete description of GAEVAL's command-line interface, run the
following command (after AEGeAn has been installed).

.. code-block:: bash

    gaeval --help

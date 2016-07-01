LocusPocus
==========

Introduction
------------

**LocusPocus** is a program for computing *interval loci* (iLoci) from a
provided set gene annotations. Each iLocus corresponds to a single gene, a set
of overlapping genes, or a space between genes. See :doc:`this page <loci>` for
a description of iLoci as an organizational principle for genomics.

Input
-----

Input for LocusPocus is one or more files in GFF3 format (LocusPocus can also
read from standard input if a dash (`-`) is provided as the input filename).
At a bare minimum, the only requirement is that the input must be `valid GFF3`_
and contain gene features. See :doc:`this page <gff3>` for a discussion of
common pitfalls and :ref:`instructions <GFF3ValidationDocs>` for validating a
GFF3 file's syntax and compatibility with LocusPocus.

Users can override `gene` as the default feature of interest, replace it with
one or more other feature types, and construct iLoci for these features in the
same way.

.. _`valid GFF3`: http://sequenceontology.org/resources/gff3.html

Output
------

LocusPocus computes the location of the iLoci from the given gene features and
reports the iLocus locations in GFF3 format. By default, only the iLocus
features themselves are reported, with attributes indicating the number of
genes and transcripts in the locus. Invoking the `--verbose` option enables
reporting of the gene features (and their subfeatures) as well.

Running LocusPocus
------------------

For a complete description of LocusPocus' command-line interface, run the
following command (after AEGeAn has been installed).

.. code-block:: bash

    locuspocus --help

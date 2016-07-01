-- Copyright (c) 2016, Daniel S. Standage and CONTRIBUTORS
--
-- The AEGeAn Toolkit is distributed under the ISC License. See
-- the 'LICENSE' file in the AEGeAn source code distribution or
-- online at https://github.com/standage/AEGeAn/blob/master/LICENSE.


-- Annotation specification of intermediate stringency. Compliant GFF3 files are
-- guaranteed to produce valid and complete output with the lpdriver.py script.
-- The LocusPocus program does not report all fiLoci. The uloci.py script
-- reports the fiLoci that LocusPocus does not. The lpdriver.py script executes
-- LocusPocus and uloci.py and combines their output to provide a full
-- complement of iLoci representing the entire genome.


-- Load functions from 'generic.lua'
require(debug.getinfo(1).source:match("@?(.*/)") .. "generic")


describe.region(function(region)
    is_complete_seq(region)
end)

describe.feature("gene", function(gene)
    is_root_feature(gene)
    encompasses_children(gene)
    has_transcript_with_exons(gene)
end)

describe.feature("mRNA", function(mrna)
    encompasses_children(mrna)
    has_cds(mrna)
    has_single_cds(mrna)
    has_non_overlapping_exons(mrna)
    has_reasonable_introns(mrna)
end)

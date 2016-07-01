-- Copyright (c) 2016, Daniel S. Standage and CONTRIBUTORS
--
-- The AEGeAn Toolkit is distributed under the ISC License. See
-- the 'LICENSE' file in the AEGeAn source code distribution or
-- online at https://github.com/standage/AEGeAn/blob/master/LICENSE.

-- Load functions from 'generic.lua'
require(debug.getinfo(1).source:match("@?(.*/)") .. "generic")


describe.feature("gene", function(gene)
    encompasses_children(gene)
    is_protein_coding(gene)
end)

describe.feature("mRNA", function(mrna)
    local has_exons = mrna:has_child_of_type("exon")
    local has_coding_exons = mrna:has_child_of_type("CDS")

    encompasses_children(mrna)
    has_non_overlapping_exons(mrna)
    has_reasonable_introns(mrna)
    has_cds_relaxed(mrna)
    has_single_cds(mrna)

    it("is associated with a gene feature", function()
        expect(mrna:appears_as_child_of_type("gene")).should_be(true)
    end)

    it("specifies exon/intron structure", function()
        expect(has_exons or has_coding_exons).should_be(true)
    end)
end)

describe.feature("exon", function(exon)
    has_mrna_parent(exon)
end)

describe.feature("CDS", function(coding_exon)
    has_mrna_parent(coding_exon)
end)

-- Copyright (c) 2016, Daniel S. Standage and CONTRIBUTORS
--
-- The AEGeAn Toolkit is distributed under the ISC License. See
-- the 'LICENSE' file in the AEGeAn source code distribution or
-- online at https://github.com/standage/AEGeAn/blob/master/LICENSE.


encompasses_children = function(feat)
    it("encompasses all subfeatures", function()
        for child in feat:children() do
            expect(feat:get_range():contains(child:get_range())).should_be(true)
        end
    end)
end

is_root_feature = function(feat)
    it("is top-level feature", function()
        expect(feat:appears_as_root_node()).should_be(true)
    end)
end

is_protein_coding = function(gene)
    it("is a protein-coding gene", function()
        expect(gene:has_child_of_type("mRNA")).should_be(true)
    end)
end

is_complete_seq = function(region)
    it("describes a complete chromosome/scaffold/contig sequence", function()
        seqid = region:get_seqid()
        regstart = region:get_range():get_start()
        regend = region:get_range():get_end()
        expect(regstart).should_be(1)
        expect(regend).should_be(region_mapping:get_sequence_length(seqid))
    end)
end

has_transcript_with_exons = function(gene)
    it("has transcript(s) with fully defined exon structure", function()
        expect(gene:has_child_of_supertype("transcript")).should_be(true)
        for transcript in gene:children_of_supertype("transcript") do
            expect(transcript:has_child_of_type("exon")).should_be(true)
        end
    end)
end

has_non_overlapping_exons = function(transcript)
    it("has non-overlapping exons", function()
        prev = {}
        overlap = false
        for exon in transcript:children_of_type("exon") do
            if (table.getn(prev) == 0) then
                table.insert(prev, exon)
            else
                for i, otherexon in ipairs(prev) do
                    if (exon:get_range():overlap(otherexon:get_range())) then
                        overlap = true
                        break
                    end
                end
            end
        end
        expect(overlap).should_be(false)
    end)
end

has_reasonable_introns = function(transcript)
    it("has (numexon - 1) introns, if introns explicitly declared", function()
        introncount = count(transcript:children_of_type("intron"))
        if (introncount > 0) then
            exoncount = count(transcript:children_of_type("exon"))
            expect(introncount).should_be(exoncount - 1)
        end
    end)
end

has_cds = function(mrna)
    it("has an explicitly defined coding sequence", function()
        expect(mrna:has_child_of_type("CDS")).should_be(true)
    end)
end

has_cds_relaxed = function(mrna)
    local has_coding_exons = mrna:has_child_of_type("CDS")
    local has_exons = mrna:has_child_of_type("exon")
    local has_codons = mrna:has_child_of_type("start_codon") and
                       mrna:has_child_of_type("stop_codon")
    local has_implicit_cds = has_exons and has_codons
    it("has a coding sequence", function()
        expect(has_coding_exons or has_implicit_cds).should_be(true)
    end)
end

has_single_cds = function(mrna)
    it("has a single coding sequence", function()
        cdsid = nil
        consistent = true
        for cexon in mrna:children_of_type("CDS") do
            if cdsid == nil then
                cdsid = cexon:get_attribute("ID")
            else
                consistent = consistent and cexon:get_attribute("ID") == cdsid
            end
        end
        expect(consistent).should_be(true)
    end)
end

has_mrna_parent = function(feature)
    it("is associated with an mRNA", function()
        expect(feature:appears_as_child_of_type("mRNA")).should_be(true)
    end)
end

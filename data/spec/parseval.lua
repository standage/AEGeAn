describe.feature("gene", function(gene)
    it("is a protein-coding gene", function()
        expect(gene:has_child_of_type("mRNA")).should_be(true)
    end)

    it("encompasses all child features", function()
        for child in gene:children() do
            expect(gene:get_range():contains(child:get_range())).should_be(true)
        end
    end)
end)

describe.feature("mRNA", function(mrna)
    local has_exons = mrna:has_child_of_type("exon")
    local has_introns = mrna:has_child_of_type("intron")
    local has_coding_exons = mrna:has_child_of_type("CDS")

    it("is associated with a gene feature", function()
        expect(mrna:appears_as_child_of_type("gene")).should_be(true)
    end)

    it("specifies exon/intron structure", function()
        expect(has_exons or has_coding_exons).should_be(true)
    end)

    it("has non-overlapping exons", function()
        exons = {}
        overlap = false
        for child in mrna:children() do
            if (child:get_type() == "exon") then
                for i, sibling in ipairs(exons) do
                    if (child:get_range():overlap(sibling:get_range())) then
                        overlap = true
                    end
                end
                table.insert(exons, child)
            end
        end
        expect(overlap).should_be(false)
    end)

    it("specifies a coding sequence", function()
        local has_codons = mrna:has_child_of_type("start_codon") and
                           mrna:has_child_of_type("stop_codon")
        expect((has_exons and has_codons) or has_coding_exons).should_be(true)
    end)

    it("encompasses all child features", function()
        for child in mrna:children() do
            expect(mrna:get_range():contains(child:get_range())).should_be(true)
        end
    end)
end)

describe.feature("exon", function(exon)
    it("is associated with an mRNA", function()
        expect(exon:appears_as_child_of_type("mRNA")).should_be(true)
    end)
end)

describe.feature("CDS", function(cds_exon)
    it("is associated with an mRNA", function()
        expect(cds_exon:appears_as_child_of_type("mRNA")).should_be(true)
    end)
end)

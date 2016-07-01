-- Copyright (c) 2016, Daniel S. Standage and CONTRIBUTORS
--
-- The AEGeAn Toolkit is distributed under the ISC License. See
-- the 'LICENSE' file in the AEGeAn source code distribution or
-- online at https://github.com/standage/AEGeAn/blob/master/LICENSE.

-- Load functions from 'generic.lua'
require(debug.getinfo(1).source:match("@?(.*/)") .. "generic")


describe.feature("gene", function(gene)
    is_root_feature(gene)
    encompasses_children(gene)
end)

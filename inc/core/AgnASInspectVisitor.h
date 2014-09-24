/**

Copyright (c) 2010-2014, Daniel S. Standage and CONTRIBUTORS

The AEGeAn Toolkit is distributed under the ISC License. See
the 'LICENSE' file in the AEGeAn source code distribution or
online at https://github.com/standage/AEGeAn/blob/master/LICENSE.

**/

#ifndef AEGEAN_AS_INSPECT_VISITOR
#define AEGEAN_AS_INSPECT_VISITOR

#include "extended/node_stream_api.h"
#include "AgnUnitTest.h"

/**
 * @class AgnASInspectVisitor
 *
 * Implements the GenomeTools ``GtNodeVisitor`` interface. This is a node
 * visitor used for summarizing the extent of alternative splicing in an
 * annotation.
 */
typedef struct AgnASInspectVisitor AgnASInspectVisitor;

/**
 * @function Constructor for a node stream based on this node visitor.
 */
GtNodeStream* agn_as_inspect_stream_new(GtNodeStream *in);

/**
 * @function Constructor.
 */
GtNodeVisitor *agn_as_inspect_visitor_new();

#endif

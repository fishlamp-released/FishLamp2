//
//	GtStorageAttribute.h
//	PackMule
//
//	Created by Mike Fullerton on 4/3/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtBitFlags.h"

// using bit flags so you can build it quick inline, e.g. a | b | c

typedef enum 
{
	GtStorageAttributeStored		= 0, // default to stored.
	GtStorageAttributeNotStored		= (1 << 1),
	GtStorageAttributePrimaryKey	= (1 << 2),
	GtStorageAttributeIndexed		= (1 << 3),
	GtStorageAttributeRequired		= (1 << 4),
	GtStorageAttributeUnique		= (1 << 5),
	
// internal use only	
	GtStorageAttributeSystemItem	= (1 << 6) 
} GtStorageAttribute;

#define GtStorageAttributeHasColumn(__attr__)		!GtBitMaskTest((__attr__), GtStorageAttributeNotStored)
#define GtStorageAttributeIsPrimaryKey(__attr__)   GtBitMaskTest((__attr__), GtStorageAttributePrimaryKey)
#define GtStorageAttributeIsIndexed(__attr__)		 GtBitMaskTest((__attr__), GtStorageAttributeIndexed)
#define GtStorageAttributeIsRequired(__attr__)		GtBitMaskTest((__attr__), GtStorageAttributeRequired)
#define GtStorageAttributeIsUnique(__attr__)		GtBitMaskTest((__attr__), GtStorageAttributeUnique)



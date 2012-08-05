//
//	FLStorageAttribute.h
//	PackMule
//
//	Created by Mike Fullerton on 4/3/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLBitFlags.h"
#import "FishLampCocoa.h"

// using bit flags so you can build it quick inline, e.g. a | b | c

typedef enum 
{
	FLStorageAttributeStored		= 0, // default to stored.
	FLStorageAttributeNotStored		= (1 << 1),
	FLStorageAttributePrimaryKey	= (1 << 2),
	FLStorageAttributeIndexed		= (1 << 3),
	FLStorageAttributeRequired		= (1 << 4),
	FLStorageAttributeUnique		= (1 << 5),
	
// internal use only	
	FLStorageAttributeSystemItem	= (1 << 6) 
} FLStorageAttribute;

#define FLStorageAttributeHasColumn(__attr__)		!FLBitTest((__attr__), FLStorageAttributeNotStored)
#define FLStorageAttributeIsPrimaryKey(__attr__)   FLBitTest((__attr__), FLStorageAttributePrimaryKey)
#define FLStorageAttributeIsIndexed(__attr__)		 FLBitTest((__attr__), FLStorageAttributeIndexed)
#define FLStorageAttributeIsRequired(__attr__)		FLBitTest((__attr__), FLStorageAttributeRequired)
#define FLStorageAttributeIsUnique(__attr__)		FLBitTest((__attr__), FLStorageAttributeUnique)



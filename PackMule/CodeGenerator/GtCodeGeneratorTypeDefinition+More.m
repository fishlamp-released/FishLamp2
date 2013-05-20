//
//	GtCodeGeneratorTypeDefinition+More.m
//	PackMule
//
//	Created by Mike Fullerton on 12/19/10.
//	Copyright 2010 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorTypeDefinition+More.h"


@implementation GtCodeGeneratorTypeDefinition  (More)

- (BOOL) dataTypeIsEnum
{
	return GtStringsAreEqual(self.dataType, GtCodeGeneratorDataTypeEnum);
}

- (BOOL) dataTypeIsObject
{
	return GtStringIsEmpty(self.dataType) || GtStringsAreEqual(self.dataType, GtCodeGeneratorDataTypeObject);
}

- (BOOL) dataTypeIsValue
{
	return GtStringsAreEqual(self.dataType, GtCodeGeneratorDataTypeValue);
}

@end

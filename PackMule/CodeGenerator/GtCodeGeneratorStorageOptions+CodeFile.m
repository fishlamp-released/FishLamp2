//
// GtCodeGeneratorStorageOptions+CodeFile.m
// Project: FishLamp Code Generator
// Schema: GtCodeGenerator
//
// Copywrite 2010 GreenTongue Software. All rights reserved.
//

#import "GtCodeGeneratorStorageOptions.h"

@implementation GtCodeGeneratorStorageOptions (CodeFile)

- (NSString*) storageMask
{
	NSMutableString* storageMask = [NSMutableString string];

	if(!self.isStorable.boolValue)
	{
		[storageMask appendString:@"GtStorageAttributeNotStored"];
	}
	else
	{
		[storageMask appendString:@"GtStorageAttributeStored"];
	}
	if(self.isPrimaryKey.boolValue)
	{
		[storageMask appendString:@"|GtStorageAttributePrimaryKey"];
	}
	if(self.isIndexed.boolValue)
	{
		[storageMask appendString:@"|GtStorageAttributeIndexed"];
	}
	if(self.isRequired.boolValue)
	{
		[storageMask appendString:@"|GtStorageAttributeRequired"];
	}
	if(self.isUnique.boolValue)
	{
		[storageMask appendString:@"|GtStorageAttributeUnique"];
	}
	
	return storageMask;
}
@end

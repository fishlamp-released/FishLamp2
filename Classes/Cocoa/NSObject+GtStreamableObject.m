// This file was generated at 4/6/10 1:07 PM by PackMule. DO NOT MODIFY!!
//
// GtObject.m
// FishLamp
//
//
// Copywrite 2010 GreentTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSObject+GtStreamableObject.h"
#import "GtObjectInflatorState.h"

#import <objc/runtime.h>

@implementation NSObject (GtStreamableObject)

- (BOOL) describeSelfToStringBuilder:(GtStringBuilder*) stringBuilder
{
// TODO: fix this

	BOOL describedSelf = NO;
//	for(NSUInteger i = 0; i < [[self class] propertyDataTypeStructCount]; i++)
//	{
//		describedSelf = YES;
//		GtDataTypeStruct* dataTypeStruct = [[self class] propertyDataTypeStructByIndex: i];
//		GtAssertNotNil(dataTypeStruct);
//		
//		id propertyValue = GtPerformDataTypeStructGetter(self, dataTypeStruct);
//		if(propertyValue)
//		{
//			[propertyValue debugDescription:dataTypeStruct->key stringBuilder:stringBuilder];
//		}
//	} 

	return describedSelf;
}

- (void) debugDescription:(NSString*) name stringBuilder:(GtStringBuilder*) stringBuilder
{
	[stringBuilder appendLineWithFormat:@"%@: <%@ (0x%X)> {", name, NSStringFromClass([self class]), (void*) self];
//	[stringBuilder tabIn];
	
	if(![self describeSelfToStringBuilder:stringBuilder])
	{	
		[stringBuilder appendLine:[self description]]; 
	}
//	[stringBuilder tabOut];
	[stringBuilder appendLine:@"}"];
	
}

//- (NSString*) debugDescription
//{
//	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
//	
//	[self debugDescription:NSStringFromClass([self class]) stringBuilder:builder];
//	
//	return [builder buildString];
//}

#ifndef NEW_PARSER
- (void) finishStreamingFrom:(GtObjectInflatorState*) state
{
	GtPerformDataTypeStructSetter(self, state.type, state.data);
}

- (BOOL) beginStreamingFrom:(GtObjectInflatorState*) state
{
	state.type = [[self class] propertyDataTypeStructByName:state.key];
	if(state.type)
	{
		if(state.type->typeID == GtDataTypeObject)
		{
			id object = [GtPerformDataTypeStructGetter(self, state.type) retain];
			if(!object)
			{
				object = [[state.type->objectClass alloc] init];
				GtPerformDataTypeStructSetter(self, state.type, object);
			}
		
			GtAssertNotNil(object);
		
			state.object = object;
			GtRelease(object);
		}
		
		return YES;
	}
	
	return NO;
}
#endif

@end

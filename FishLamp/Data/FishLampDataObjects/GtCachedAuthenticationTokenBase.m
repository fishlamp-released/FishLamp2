// This file was generated at 2/6/10 2:05 PM by PackMule. DO NOT MODIFY!!
//
// GtCachedAuthenticationTokenBase.m
// FishLamp
//
//
// Copywrite 2009 GreenTongue Software. All rights reserved.
//

#import "GtCachedAuthenticationTokenBase.h"
#if FISHLAMPDATAOBJECTS_ENABLED

@implementation GtCachedAuthenticationTokenBase

#if !IPHONE
+ (GtCachedAuthenticationTokenBase*) objectWithXmlParseKey:(NSString*) key
{
	return [[[GtCachedAuthenticationTokenBase alloc] initWithXmlParseKey:key] autorelease];
}

+ (GtCachedAuthenticationTokenBase*) object
{
	return [[[GtCachedAuthenticationTokenBase alloc] init] autorelease];
}

+ (GtCachedAuthenticationTokenBase*) objectWithObject:(GtCachedAuthenticationTokenBase*) object
{
	return [[[GtCachedAuthenticationTokenBase alloc] initWithObject:object] autorelease];
}
#endif
// token property
- (NSString*) token {  
	return [self objectForKey:@"token"];  
}  
- (void) setToken:(NSString*) inValue {  
	[self setObject:inValue forKey:@"token"];  
}
- (NSString*) tokenObject { 
	return (NSString*) [self objectForKey:@"token"]; 
} 
+ (NSString*) tokenKey { 
	return @"token"; 
} 
- (BOOL) tokenHasValue { 
	NSString* str = [self.objectData objectForKey:@"token"];
	return str != nil && str.length > 0;
} 
- (void) removeToken {
	return [self.objectData removeObjectForKey:@"token"];
}

// token property end

// id property
- (int) id {  
	NSNumber* num = (NSNumber*) [self objectForKey:@"id"];  
	if(!num)
	{
		@throw [NSException exceptionWithName:@"Nil Object" reason:@"Number value is nil, check idHasValue first" userInfo:nil];
	}
	
	return num.intValue;  
}  
- (void) setId:(int) inValue {  
	[self setObject:[NSNumber numberWithInt:inValue] forKey:@"id"];  
}
- (NSNumber*) idObject { 
	return (NSNumber*) [self objectForKey:@"id"]; 
} 
+ (NSString*) idKey { 
	return @"id"; 
} 
- (BOOL) idHasValue { 
	return [self.objectData objectForKey:@"id"] != nil;
} 
- (void) removeId {
	return [self.objectData removeObjectForKey:@"id"];
}

// id property end

- (void) onAddDataDescriptors:(NSMutableDictionary*) dataDescriptors {
	GtAddDataDescriptorForType(dataDescriptors, token, gtStringType);//1
	GtAddDataDescriptorForType(dataDescriptors, id, gtIntegerType);//1
	[super onAddDataDescriptors:dataDescriptors]; 
}

- (void) onAddDefaultValues:(NSMutableDictionary*) defaults {
	[super onAddDefaultValues:defaults]; 
}
@end 
#endif
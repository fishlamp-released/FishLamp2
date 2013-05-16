// This file was generated at 2/6/10 2:03 PM by PackMule. DO NOT MODIFY!!
//
// GtUserLogin.m
// FishLamp
//
//
// Copywrite 2009 GreenTongue Software. All rights reserved.
//

#import "GtUserLogin.h"
#if FISHLAMPDATAOBJECTS_ENABLED

@implementation GtUserLogin

#if !IPHONE
+ (GtUserLogin*) objectWithXmlParseKey:(NSString*) key
{
	return [[[GtUserLogin alloc] initWithXmlParseKey:key] autorelease];
}

+ (GtUserLogin*) object
{
	return [[[GtUserLogin alloc] init] autorelease];
}

+ (GtUserLogin*) objectWithObject:(GtUserLogin*) object
{
	return [[[GtUserLogin alloc] initWithObject:object] autorelease];
}
#endif
// userName property
- (NSString*) userName {  
	return [self objectForKey:@"userName"];  
}  
- (void) setUserName:(NSString*) inValue {  
	[self setObject:inValue forKey:@"userName"];  
}
- (NSString*) userNameObject { 
	return (NSString*) [self objectForKey:@"userName"]; 
} 
+ (NSString*) userNameKey { 
	return @"userName"; 
} 
- (BOOL) userNameHasValue { 
	NSString* str = [self.objectData objectForKey:@"userName"];
	return str != nil && str.length > 0;
} 
- (void) removeUserName {
	return [self.objectData removeObjectForKey:@"userName"];
}

// userName property end

// password property
- (NSString*) password {  
	return [self objectForKey:@"password"];  
}  
- (void) setPassword:(NSString*) inValue {  
	[self setObject:inValue forKey:@"password"];  
}
- (NSString*) passwordObject { 
	return (NSString*) [self objectForKey:@"password"]; 
} 
+ (NSString*) passwordKey { 
	return @"password"; 
} 
- (BOOL) passwordHasValue { 
	NSString* str = [self.objectData objectForKey:@"password"];
	return str != nil && str.length > 0;
} 
- (void) removePassword {
	return [self.objectData removeObjectForKey:@"password"];
}

// password property end

// userGuid property
- (NSString*) userGuid {  
	return [self objectForKey:@"userGuid"];  
}  
- (void) setUserGuid:(NSString*) inValue {  
	[self setObject:inValue forKey:@"userGuid"];  
}
- (NSString*) userGuidObject { 
	return (NSString*) [self objectForKey:@"userGuid"]; 
} 
+ (NSString*) userGuidKey { 
	return @"userGuid"; 
} 
- (BOOL) userGuidHasValue { 
	NSString* str = [self.objectData objectForKey:@"userGuid"];
	return str != nil && str.length > 0;
} 
- (void) removeUserGuid {
	return [self.objectData removeObjectForKey:@"userGuid"];
}

// userGuid property end

- (void) onAddDataDescriptors:(NSMutableDictionary*) dataDescriptors {
	GtAddDataDescriptorForType(dataDescriptors, userName, gtStringType);//1
	GtAddDataDescriptorForType(dataDescriptors, password, gtStringType);//1
	GtAddDataDescriptorForType(dataDescriptors, userGuid, gtStringType);//1
	[super onAddDataDescriptors:dataDescriptors]; 
}

- (void) onAddDefaultValues:(NSMutableDictionary*) defaults {
	[super onAddDefaultValues:defaults]; 
}
@end 
#endif
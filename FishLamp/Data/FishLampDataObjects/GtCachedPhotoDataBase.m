// This file was generated at 11/4/09 5:26 PM by PackMule. DO NOT MODIFY!!
//
// GtCachedPhotoDataBase.m
// FishLamp
//
//
// Copywrite 2009 GreenTongue Software. All rights reserved.
//

#import "GtCachedPhotoDataBase.h"
#if FISHLAMPDATAOBJECTS_ENABLED

@implementation GtCachedPhotoDataBase

#if !IPHONE
+ (GtCachedPhotoDataBase*) objectWithXmlParseKey:(NSString*) key
{
	return [[[GtCachedPhotoDataBase alloc] initWithXmlParseKey:key] autorelease];
}

+ (GtCachedPhotoDataBase*) object
{
	return [[[GtCachedPhotoDataBase alloc] init] autorelease];
}

+ (GtCachedPhotoDataBase*) objectWithObject:(GtCachedPhotoDataBase*) object
{
	return [[[GtCachedPhotoDataBase alloc] initWithObject:object] autorelease];
}
#endif
// filePath property
- (NSString*) filePath {  
	return [self objectForKey:@"filePath"];  
}  
- (void) setFilePath:(NSString*) inValue {  
	[self setObject:inValue forKey:@"filePath"];  
}
- (NSString*) filePathObject { 
	return (NSString*) [self objectForKey:@"filePath"]; 
} 
+ (NSString*) filePathKey { 
	return @"filePath"; 
} 
- (BOOL) filePathHasValue { 
	NSString* str = [self.objectData objectForKey:@"filePath"];
	return str != nil && str.length > 0;
} 
- (void) removeFilePath {
	return [self.objectData removeObjectForKey:@"filePath"];
}

// filePath property end

// url property
- (NSString*) url {  
	return [self objectForKey:@"url"];  
}  
- (void) setUrl:(NSString*) inValue {  
	[self setObject:inValue forKey:@"url"];  
}
- (NSString*) urlObject { 
	return (NSString*) [self objectForKey:@"url"]; 
} 
+ (NSString*) urlKey { 
	return @"url"; 
} 
- (BOOL) urlHasValue { 
	NSString* str = [self.objectData objectForKey:@"url"];
	return str != nil && str.length > 0;
} 
- (void) removeUrl {
	return [self.objectData removeObjectForKey:@"url"];
}

// url property end

- (void) onAddDataDescriptors:(NSMutableDictionary*) dataDescriptors {
	GtAddDataDescriptorForType(dataDescriptors, filePath, gtStringType);//1
	GtAddDataDescriptorForType(dataDescriptors, url, gtStringType);//1
	[super onAddDataDescriptors:dataDescriptors]; 
}

- (void) onAddDefaultValues:(NSMutableDictionary*) defaults {
	[super onAddDefaultValues:defaults]; 
}
@end 
#endif
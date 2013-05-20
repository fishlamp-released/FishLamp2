// This file was generated at 12/27/09 11:38 AM by PackMule. DO NOT MODIFY!!
//
// GtSoapFault11.m
// FishLamp
//
//
// Copywrite 2009 GreenTongue Software. All rights reserved.
//

#import "GtSoapFault11.h"
#if GTSOAPOBJECTSSCHEMA11_ENABLED

@implementation GtSoapFault11

#if !IPHONE
+ (GtSoapFault11*) objectWithXmlParseKey:(NSString*) key
{
	return [[[GtSoapFault11 alloc] initWithXmlParseKey:key] autorelease];
}

+ (GtSoapFault11*) object
{
	return [[[GtSoapFault11 alloc] init] autorelease];
}

+ (GtSoapFault11*) objectWithObject:(GtSoapFault11*) object
{
	return [[[GtSoapFault11 alloc] initWithObject:object] autorelease];
}
#endif
// faultcode property
- (NSString*) faultcode {  
	return [self objectForKey:@"faultcode"];  
}  
- (void) setFaultcode:(NSString*) inValue {  
	[self setObject:inValue forKey:@"faultcode"];  
}
- (NSString*) faultcodeObject { 
	return (NSString*) [self objectForKey:@"faultcode"]; 
} 
+ (NSString*) faultcodeKey { 
	return @"faultcode"; 
} 
- (BOOL) faultcodeHasValue { 
	NSString* str = [self.objectData objectForKey:@"faultcode"];
	return str != nil && str.length > 0;
} 
- (void) removeFaultcode {
	return [self.objectData removeObjectForKey:@"faultcode"];
}

// faultcode property end

// faultstring property
- (NSString*) faultstring {  
	return [self objectForKey:@"faultstring"];  
}  
- (void) setFaultstring:(NSString*) inValue {  
	[self setObject:inValue forKey:@"faultstring"];  
}
- (NSString*) faultstringObject { 
	return (NSString*) [self objectForKey:@"faultstring"]; 
} 
+ (NSString*) faultstringKey { 
	return @"faultstring"; 
} 
- (BOOL) faultstringHasValue { 
	NSString* str = [self.objectData objectForKey:@"faultstring"];
	return str != nil && str.length > 0;
} 
- (void) removeFaultstring {
	return [self.objectData removeObjectForKey:@"faultstring"];
}

// faultstring property end

// faultactor property
- (NSString*) faultactor {  
	return [self objectForKey:@"faultactor"];  
}  
- (void) setFaultactor:(NSString*) inValue {  
	[self setObject:inValue forKey:@"faultactor"];  
}
- (NSString*) faultactorObject { 
	return (NSString*) [self objectForKey:@"faultactor"]; 
} 
+ (NSString*) faultactorKey { 
	return @"faultactor"; 
} 
- (BOOL) faultactorHasValue { 
	NSString* str = [self.objectData objectForKey:@"faultactor"];
	return str != nil && str.length > 0;
} 
- (void) removeFaultactor {
	return [self.objectData removeObjectForKey:@"faultactor"];
}

// faultactor property end

// detail property
- (NSString*) detail {  
	return [self objectForKey:@"detail"];  
}  
- (void) setDetail:(NSString*) inValue {  
	[self setObject:inValue forKey:@"detail"];  
}
- (NSString*) detailObject { 
	return (NSString*) [self objectForKey:@"detail"]; 
} 
+ (NSString*) detailKey { 
	return @"detail"; 
} 
- (BOOL) detailHasValue { 
	NSString* str = [self.objectData objectForKey:@"detail"];
	return str != nil && str.length > 0;
} 
- (void) removeDetail {
	return [self.objectData removeObjectForKey:@"detail"];
}

// detail property end

- (void) onAddDataDescriptors:(NSMutableDictionary*) dataDescriptors {
	GtAddDataDescriptorForType(dataDescriptors, faultcode, gtStringType);//1
	GtAddDataDescriptorForType(dataDescriptors, faultstring, gtStringType);//1
	GtAddDataDescriptorForType(dataDescriptors, faultactor, gtStringType);//1
	GtAddDataDescriptorForType(dataDescriptors, detail, gtStringType);//1
	[super onAddDataDescriptors:dataDescriptors]; 
}

- (void) onAddDefaultValues:(NSMutableDictionary*) defaults {
	[super onAddDefaultValues:defaults]; 
}
@end 
#endif
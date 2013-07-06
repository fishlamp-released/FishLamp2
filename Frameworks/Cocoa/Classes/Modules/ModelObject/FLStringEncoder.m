//
//  FLDataTypeID.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/8/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStringEncoder.h"
#import "ISO8601DateFormatter.h"
#import "FLBase64Data.h"

@implementation NSObject (FLEncodingSelectors)
+ (NSString*) stringEncodingKey {
    return NSStringFromClass([self class]);
}
@end

@implementation FLStringEncoder

+ (id) stringEncoder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSString*) stringFromObject:(id) object {
    FLAssert([object isKindOfClass:[NSString class]]);
    return object;
}

- (id) objectFromString:(NSString*) string {
    return string;
}

- (NSArray*) encodingKeys {
    return [NSArray arrayWithObject:[NSString stringEncodingKey]];
}

@end

@implementation FLISO8601DateStringEncoder

- (id) init {	
	self = [super init];
	if(self) {
		self.parsesStrictly = NO;
	}
	return self;
}

+ (id) dateStringEncoder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSString*) stringFromObject:(id) object {
    return [self stringFromDate:object];
}

- (id) objectFromString:(NSString*) string {
    return [self dateFromString:string];
}

- (NSArray*) encodingKeys {
    return [NSArray arrayWithObject:[NSDate stringEncodingKey]];
}

@end

@implementation FLBase64DataStringEncoder

- (id) initWithStringEncoder:(id<FLStringEncoding>) stringEncoder {
	self = [super init];
	if(self) {
		_stringEncoder = FLRetain(stringEncoder);
	}
	return self;
}

+ (id) base64DataStringEncoder:(id<FLStringEncoding>) stringEncoder {
    return FLAutorelease([[[self class] alloc] initWithStringEncoder:stringEncoder]);
}

#if FL_MRC
- (void)dealloc {
	[_stringEncoder release];
	[super dealloc];
}
#endif

- (NSString*) stringFromObject:(id) object {
    return [_stringEncoder stringFromObject:[object encodedData]];
}

- (id) objectFromString:(NSString*) string {
    return [FLBase64Data base64DataWithEncodedData:[_stringEncoder objectFromString:string]]; // [self dateFromString:string];
}

- (NSArray*) encodingKeys {
    return [NSArray arrayWithObject:[FLBase64Data stringEncodingKey]];
}


@end

@implementation FLURLStringEncoder

+ (id) urlStringEncoder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSString*) stringFromObject:(id) object {
    return [object absoluteString];
}

- (id) objectFromString:(NSString*) string {
    return [NSURL URLWithString:string];
}

- (NSArray*) encodingKeys {
    return [NSArray arrayWithObject:[NSURL stringEncodingKey]];
}

@end

@implementation FLNumberStringEncoder

+ (id) numberStringEncoder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSString*) stringFromObject:(id) object {
    return [self stringFromNumber:object];
}

- (id) objectFromString:(NSString*) string {
    return [self numberFromString:string];
}

- (NSArray*) encodingKeys {
    return [NSArray arrayWithObjects:   @"char",
                                        @"unsigned char",
                                        @"int",
                                        @"integer",
                                        @"unsigned",
                                        @"unsigned long",
                                        @"long",
                                        @"double",
                                        @"float",
                                        @"short",
                                        @"unsigned short",
                                        @"NSInteger",
                                        @"NSUInteger",
                                        [NSNumber stringEncodingKey],
                                        nil];
}



@end

@implementation FLUTF8DataStringEncoder

+ (id) utf8DataStringEncoder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSString*) stringFromObject:(id) object {
    return FLAutorelease([[NSString alloc] initWithBytes:[object bytes] 
                                    length:[object length] 
                                    encoding:NSUTF8StringEncoding]);
}
- (id) objectFromString:(NSString*) string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];;
}

- (NSArray*) encodingKeys {
    return [NSArray arrayWithObject:[NSData stringEncodingKey]];
}

@end

@implementation FLBoolStringEncoder
+ (id) boolStringEncoder {
    return FLAutorelease([[[self class] alloc] init]);
}
- (NSString*) stringFromObject:(id) object {
    return [object boolValue] ? @"true" : @"false";
}
- (id) objectFromString:(NSString*) string {
    return [NSNumber numberWithBool:[string boolValue]];
}

- (NSArray*) encodingKeys {
    return [NSArray arrayWithObjects:   @"bool",
                                        @"boolean",
                                        [FLBoolStringEncoder stringEncodingKey],
                                        nil];
}

@end


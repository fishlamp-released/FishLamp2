//
//  FLDataTypeID.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/8/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStringEncoder.h"
#import "ISO8601DateFormatter.h"

//@interface FLStringEncoder ()
//@end
//
//@implementation FLStringEncoder
//
//@synthesize encodeSelector = _encodeSelector;
//@synthesize decodeSelector = _decodeSelector;
//
//- (id) initWithEncodingKey:(NSString*) encodingKey {
//
//    FLAssert([encodingKey rangeOfString:@"_"].length == 0);
//
//    self = [super init];
//    if(self) {
//        self.encodeSelector = NSSelectorFromString([NSString stringWithFormat:@"encodeStringWith%@:", encodingKey]);
//        self.decodeSelector = NSSelectorFromString([NSString stringWithFormat:@"decode%@FromString:", encodingKey]);
//    }
//
//    return self;
//}    
//
//+ (id) objectEncoderWithEncodingKey:(NSString*) encodingKey {
//	return FLAutorelease([[[self class] alloc] initWithEncodingKey:encodingKey]);
//}
//
//- (id) copyWithZone:(NSZone*) zone {
//    return FLRetain(self);
//}
//
//#pragma GCC diagnostic push
//#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"
//
//- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder {
//    return [encoder performSelector:self.encodeSelector withObject:object];
//}
//
//- (id) decodeStringToObject:(NSString*) string withDecoder:(id) decoder {
//    return [decoder performSelector:self.decodeSelector withObject:string];
//}
//
//#pragma GCC diagnostic pop
//@end

//const FLEncodingSelectors FLEncodingSelectorsZero = { nil, nil };

@implementation NSObject (FLEncodingSelectors)
+ (NSString*) stringEncodingKey {
    return NSStringFromClass([self class]);
}
@end

//@implementation NSString (FLCoreTypes)
//+ (id<FLStringEncoder>) stringEncoder {
//    FLReturnStaticObject([[FLStringEncoder alloc] initWithEncodingKey:@"String"]);
//}
//
//@end

//@implementation NSArray (FLCoreTypes)
//+ (id<FLStringEncoder>) stringEncoder {
//    FLReturnStaticObject([[FLStringEncoder alloc] initWithEncodingKey:@"Array"]);
//}
//@end

//@implementation NSMutableArray (FLCoreTypes)
//+ (id<FLStringEncoder>) stringEncoder {
//    FLReturnStaticObject([[FLMutableArrayType alloc] initWithEncodingKey:@"MutableArray"]);
//}
//@end

//@implementation NSURL (FLCoreTypes)
////+ (id<FLStringEncoder>) stringEncoder {
////    FLReturnStaticObject([[FLStringEncoder alloc] initWithEncodingKey:@"URL" ]);
////}
//
//+ (NSString*) encodingKey {
//    return @"url";
//}
//
//@end
//
//@implementation NSData (FLCoreTypes)
//+ (NSString*) encodingKey {
//    return @"data";
//}
//@end
//
//@implementation NSDate (FLCoreTypes)
//+ (NSString*) encodingKey {
//    return @"date";
//}
//@end
//
//@implementation SDKFont (FLCoreTypes)
//+ (NSString*) encodingKey {
//    return @"font";
//}
//@end
//
//@implementation SDKColor (FLCoreTypes)
//+ (NSString*) encodingKey {
//    return @"color";
//}
//@end
//
//@implementation NSNumber (FLCoreTypes) 
//+ (NSString*) encodingKey {
//    return @"number";
//}
//@end


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
@end


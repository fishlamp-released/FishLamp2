//
//  FLDataEncoder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDataEncoder.h"
#import "FLDateMgr.h"
#import "FLStringUtils.h"
#import "FLBase64Encoding.h"
#import "FLColorUtilities.h"
#import "FLDateMgr.h"

@implementation FLDataEncoder
@synthesize numberFormatter = _numberFormatter;

- (id) init {
	if((self = [super init])) {
		_numberFormatter = [[NSNumberFormatter alloc] init];
	}
	
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_numberFormatter release];
    [super dealloc];
}
#endif

// top hooks
- (NSString*) encodeDataToString:(id) data 
				forType:(FLTypeDesc*) type {
              
    return [type objectToString:data withEncoder:self];
} 

- (id) decodeDataFromString:(NSString*) string
				forType:(FLTypeDesc*) type {
    return [type stringToObject:string withDecoder:self];
}

// specific decoders for types.

- (NSString*) encodeStringWithString:(NSString*) string {
    return string;
}

- (NSString*) decodeStringFromString:(NSString*) string {
    return string;
}

- (NSString*) encodeStringWithDate:(NSDate*) date {
    return [[FLDateMgr instance] ISO8601DateToString:date];
}

- (NSDate*) decodeDateFromString:(NSString*) string {
    return [[FLDateMgr instance] ISO8601StringToDate:string];
}

- (NSString*) encodeStringWithURL:(NSURL*) URL {
    return [self encodeStringWithString:[URL absoluteString]];
}

- (NSURL*) decodeURLFromString:(NSString*) string {
    return [NSURL URLWithString:[self decodeStringFromString:string]];
}

- (NSString*) encodeStringWithRectValue:(NSValue*) value {
    return NSStringFromCGRect([value CGRectValue]);
}

- (NSValue*) decodeRectValueFromString:(NSString*) string {
    return [NSValue valueWithCGRect:CGRectFromString(string)];
}

- (NSString*) encodeStringWithPointValue:(NSValue*) value {
    return NSStringFromCGPoint([value CGPointValue]);
}

- (NSValue*) decodePointValueFromString:(NSString*) string {
    return [NSValue valueWithCGPoint:CGPointFromString(string)];
}

- (NSString*) encodeStringWithSizeValue:(NSValue*) value {
    return NSStringFromCGSize([value CGSizeValue]);
}

- (NSValue*) decodeSizeValueFromString:(NSString*) string {
    return [NSValue valueWithCGSize:CGSizeFromString(string)];
}

- (NSString*) encodeStringWithNumber:(NSNumber*) number {
    return [_numberFormatter stringFromNumber:number];
}

- (NSNumber*) decodeNumberFromString:(NSString*) string {
    return [_numberFormatter numberFromString:string];
}

- (NSData*) decodeDataFromString:(NSString*) string {
    FLAssertFailed_v(@"need to override this");
    return nil;
}

- (NSString*) encodeStringWithData:(NSString*) string {
    FLAssertFailed_v(@"need to override this");
    return nil;
}

- (UIColor*) decodeColorFromString:(NSString*) string {
    return FLColorFromRGBString(string);
}

- (NSString*) encodeStringWithColor:(UIColor*) color {
    return FLRgbStringFromColor(color);
}


@end

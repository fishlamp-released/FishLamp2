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

+ (id) dataEncoder {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_numberFormatter release];
    [super dealloc];
}
#endif

// top hooks
- (NSString*) encodeDataToString:(id) data 
				forType:(FLObjectEncoder*) type {
              
    return [type encodeObjectToString:data withEncoder:self];
} 

- (id) decodeDataFromString:(NSString*) string
				forType:(FLObjectEncoder*) type {
    return [type decodeStringToObject:string withDecoder:self];
}

// specific decoders for types.

- (NSString*) encodeStringWithNSString:(NSString*) string {
    return string;
}

- (NSString*) decodeNSStringFromString:(NSString*) string {
    return string;
}

- (NSString*) encodeStringWithNSDate:(NSDate*) date {
    return [[FLDateMgr instance] ISO8601DateToString:date];
}

- (NSDate*) decodeNSDateFromString:(NSString*) string {
    return [[FLDateMgr instance] ISO8601StringToDate:string];
}

- (NSString*) encodeStringWithNSURL:(NSURL*) URL {
    return [self encodeStringWithNSString:[URL absoluteString]];
}

- (NSURL*) decodeNSURLFromString:(NSString*) string {
    return [NSURL URLWithString:[self decodeNSStringFromString:string]];
}

- (NSString*) encodeStringWithCGRect:(NSValue*) value {
    return NSStringFromCGRect([value CGRectValue]);
}

- (NSString*) encodeStringWithCGPoint:(NSValue*) value {
    return NSStringFromCGPoint([value CGPointValue]);
}

- (NSString*) encodeStringWithCGSize:(NSValue*) value {
    return NSStringFromCGSize([value CGSizeValue]);
}

- (NSValue*) decodeCGPointFromString:(NSString*) string {
    return [NSValue valueWithCGPoint:CGPointFromString(string)];
}

- (NSValue*) decodeCGRectFromString:(NSString*) string {
    return [NSValue valueWithCGRect:CGRectFromString(string)];
}

- (NSValue*) decodeCGSizeFromString:(NSString*) string {
    return [NSValue valueWithCGSize:CGSizeFromString(string)];;
}

- (NSString*) encodeStringWithNSNumber:(NSNumber*) number {
    return [_numberFormatter stringFromNumber:number];
}

- (NSNumber*) decodeNSNumberFromString:(NSString*) string {
    return [_numberFormatter numberFromString:string];
}

- (NSData*) decodeNSDataFromString:(NSString*) string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString*) encodeStringWithNSData:(NSData*) data {
    return FLAutorelease([[NSString alloc] initWithBytes:[data bytes] 
                                    length:[data length] 
                                    encoding:NSUTF8StringEncoding]);
}

- (UIColor*) decodeUIColorFromString:(NSString*) string {
    return FLColorFromRGBString(string);
}

- (UIColor*) decodeNSColorFromString:(NSString*) string {
    return FLColorFromRGBString(string);
}

- (NSString*) encodeStringWithUIColor:(UIColor*) color {
    return FLRgbStringFromColor(color);
}

- (NSNumber*) decodeBOOLFromString:(NSString*) string {
    return [NSNumber numberWithBool:[string boolValue]];
}

- (NSString*) encodeStringWithBOOL:(NSNumber*) number {
    return [number boolValue] ? @"true" : @"false";
}

@end

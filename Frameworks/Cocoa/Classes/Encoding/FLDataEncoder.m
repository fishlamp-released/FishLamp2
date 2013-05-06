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
				forType:(id<FLStringEncoder>) type {
              
    return [type encodeObjectToString:data withEncoder:self];
} 

- (id) decodeDataFromString:(NSString*) string
				forType:(id<FLStringEncoder>) type {
    return [type decodeStringToObject:string withDecoder:self];
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

- (NSString*) encodeStringWithRect:(NSValue*) value {
    return NSStringFromCGRect([value CGRectValue]);
}

- (NSString*) encodeStringWithPoint:(NSValue*) value {
    return NSStringFromCGPoint([value CGPointValue]);
}

- (NSString*) encodeStringWithSize:(NSValue*) value {
    return NSStringFromCGSize([value CGSizeValue]);
}

- (NSValue*) decodePointFromString:(NSString*) string {
    return [NSValue valueWithCGPoint:CGPointFromString(string)];
}

- (NSValue*) decodeRectFromString:(NSString*) string {
    return [NSValue valueWithCGRect:CGRectFromString(string)];
}

- (NSValue*) decodeSizeFromString:(NSString*) string {
    return [NSValue valueWithCGSize:CGSizeFromString(string)];;
}

- (NSString*) encodeStringWithNumber:(NSNumber*) number {
    return [_numberFormatter stringFromNumber:number];
}

- (NSNumber*) decodeNumberFromString:(NSString*) string {
    return [_numberFormatter numberFromString:string];
}

- (NSData*) decodeDataFromString:(NSString*) string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString*) encodeStringWithData:(NSData*) data {
    return FLAutorelease([[NSString alloc] initWithBytes:[data bytes] 
                                    length:[data length] 
                                    encoding:NSUTF8StringEncoding]);
}

- (SDKColor*) decodeColorFromString:(NSString*) string {
    return FLColorFromString(string);
}

- (NSString*) encodeStringWithFont:(SDKFont*) font {
    return [NSString stringWithFormat:@"%@:%f", [font fontName], [font pointSize]];
}

- (SDKFont*) decodeFontFromString:(NSString*) string {
    
    NSRange semiColon = [string rangeOfString:@":"];
    FLConfirmWithComment(semiColon.location >= 0, @"unable to parse font, format should be \"fontname-style:size\"");
    
    NSString* name = [string substringToIndex:semiColon.location];
    FLConfirmWithComment(FLStringIsNotEmpty(name), @"empty font name");
    
    float size = [[string substringFromIndex:semiColon.location+1] floatValue];
    FLConfirmWithComment(size > 0, @"font size is zero");
    
    return [SDKFont fontWithName:name size:size];
}

- (NSString*) encodeStringWithColor:(SDKColor*) color {
    return FLRgbStringFromColor(color);
}

- (NSNumber*) decodeBOOLFromString:(NSString*) string {
    return [NSNumber numberWithBool:[string boolValue]];
}

- (NSString*) encodeStringWithBOOL:(NSNumber*) number {
    return [number boolValue] ? @"true" : @"false";
}

@end

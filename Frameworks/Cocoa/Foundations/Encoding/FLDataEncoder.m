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
              
    return [type encodeObjectToString:data withEncoder:self];
} 

- (id) decodeDataFromString:(NSString*) string
				forType:(FLTypeDesc*) type {
    return [type decodeStringToObject:string withDecoder:self];
}

// specific decoders for types.

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSString:(NSString*) string {
    return string;
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc decodeNSStringFromString:(NSString*) string {
    return string;
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSDate:(NSDate*) date {
    return [[FLDateMgr instance] ISO8601DateToString:date];
}

- (NSDate*) typeDesc:(FLTypeDesc*) typeDesc decodeNSDateFromString:(NSString*) string {
    return [[FLDateMgr instance] ISO8601StringToDate:string];
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSURL:(NSURL*) URL {
    return [self typeDesc:typeDesc encodeStringWithNSString:[URL absoluteString]];
}

- (NSURL*) typeDesc:(FLTypeDesc*) typeDesc decodeNSURLFromString:(NSString*) string {
    return [NSURL URLWithString:[self typeDesc:typeDesc decodeNSStringFromString:string]];
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithCGRect:(NSValue*) value {
    return NSStringFromCGRect([value CGRectValue]);
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithCGPoint:(NSValue*) value {
    return NSStringFromCGPoint([value CGPointValue]);
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithCGSize:(NSValue*) value {
    return NSStringFromCGSize([value CGSizeValue]);
}

- (NSValue*) typeDesc:(FLTypeDesc*) typeDesc decodeCGPointFromString:(NSString*) string {
    return [NSValue valueWithCGPoint:CGPointFromString(string)];
}

- (NSValue*) typeDesc:(FLTypeDesc*) typeDesc decodeCGRectFromString:(NSString*) string {
    return [NSValue valueWithCGRect:CGRectFromString(string)];
}

- (NSValue*) typeDesc:(FLTypeDesc*) typeDesc decodeCGSizeFromString:(NSString*) string {
    return [NSValue valueWithCGSize:CGSizeFromString(string)];;
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSNumber:(NSNumber*) number {
    return [_numberFormatter stringFromNumber:number];
}

- (NSNumber*) typeDesc:(FLTypeDesc*) typeDesc decodeNSNumberFromString:(NSString*) string {
    return [_numberFormatter numberFromString:string];
}

- (NSData*) typeDesc:(FLTypeDesc*) typeDesc decodeNSDataFromString:(NSString*) string {
    FLAssertFailed_v(@"need to override this");
    return nil;
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSData:(NSString*) string {
    FLAssertFailed_v(@"need to override this");
    return nil;
}

- (UIColor*) typeDesc:(FLTypeDesc*) typeDesc decodeUIColorFromString:(NSString*) string {
    return FLColorFromRGBString(string);
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithUIColor:(UIColor*) color {
    return FLRgbStringFromColor(color);
}


@end

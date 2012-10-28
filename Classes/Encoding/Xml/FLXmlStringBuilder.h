//
//	FLXmlStringBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLDataEncoder.h"
#import "FLStringBuilder.h"

// xml
#define FLXmlVersion1_0                         @"1.0"
#define FLXmlEncodingUtf8                       @"utf-8"
#define FMXmlEncodingUtf16                      @"UTF-16"

@class FLXmlElement;

@interface FLXmlStringBuilder : FLStringBuilder {
@private
	id<FLDataEncoder> _dataEncoder;
}

@property (readwrite, strong, nonatomic) id<FLDataEncoder> dataEncoder;

+ (FLXmlStringBuilder*) xmlStringBuilder;

- (void) appendXmlVersionDeclaration:(NSString*) version 
                   andEncodingHeader:(NSString*) encoding
                          standalone:(BOOL) standalone;

- (void) appendDefaultXmlDeclaration;  

- (FLXmlElement*) addElement:(NSString*) openTag closeTag:(NSString*) closeTag;
- (FLXmlElement*) addElement:(NSString*) openTag closeTag:(NSString*) closeTag value:(NSString*) value;
- (FLXmlElement*) addElement:(NSString*) name;
- (FLXmlElement*) addElement:(NSString*) name value:(NSString*) value;

@end

@interface FLXmlComment : FLXmlStringBuilder {
}
@end


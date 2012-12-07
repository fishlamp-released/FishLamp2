//
//	FLXmlStringBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"
#import "FLStringBuilder.h"

// xml
#define FLXmlVersion1_0                         @"1.0"
#define FLXmlEncodingUtf8                       @"utf-8"
#define FMXmlEncodingUtf16                      @"UTF-16"

@class FLXmlElement;

@interface FLXmlStringBuilder : FLStringBuilder {
@private
}

+ (FLXmlStringBuilder*) xmlStringBuilder;

- (void) appendXmlVersionDeclaration:(NSString*) version 
                   andEncodingHeader:(NSString*) encoding
                          standalone:(BOOL) standalone;

- (void) appendDefaultXmlDeclaration;  

- (void) addElement:(FLXmlElement*) element;

@end

@interface FLXmlComment : FLXmlStringBuilder {
}
@end


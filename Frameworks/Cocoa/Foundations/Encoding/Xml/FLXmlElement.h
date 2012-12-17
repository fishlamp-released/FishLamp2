//
//  FLXmlElement.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLCore.h"
#import "FLDataEncoder.h"
#import "FLXmlStringBuilder.h"

// This is for WRITING Xml Elements only with the FLXmlStringBuilder.

@interface FLXmlElement : FLXmlStringBuilder {
@private
	NSMutableDictionary* _attributes;
    NSString* _openTag;
    NSString* _closeTag;
    
    FLXmlComment* _comments;
}

@property (readonly, strong, nonatomic) FLXmlComment* comments;

@property (readonly, strong, nonatomic) NSString* openTag;
@property (readonly, strong, nonatomic) NSString* closeTag;

- (id) initWithOpenTag:(NSString*) tag closeTag:(NSString*) closeTag;
- (id) initWithName:(NSString*) tag;

+ (id) xmlElement:(NSString*) openTag closeTag:(NSString*) closeTag;
+ (id) xmlElement:(NSString*) name;

- (void) setAttribute:(NSString*) attributeValue forKey:(NSString*) key;
- (void) appendAttribute:(NSString*) attributeValue forKey:(NSString*) key;



@end


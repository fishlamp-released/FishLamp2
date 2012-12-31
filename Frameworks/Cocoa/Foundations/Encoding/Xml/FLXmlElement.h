//
//  FLXmlElement.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLStringBuilder.h"

@protocol FLDataEncoder;
@class FLPropertyDescription;
@class FLXmlStringBuilder;
@class FLXmlComment;

// This is for WRITING Xml Elements only with the FLXmlStringBuilder.
@interface FLXmlElement : FLStringBuilder {
@private
	NSMutableDictionary* _attributes;
    NSString* _openTag;
    NSString* _closeTag;
    
    FLXmlComment* _comments;
}

@property (readonly, strong, nonatomic) FLXmlComment* comments;

@property (readonly, strong, nonatomic) NSString* xmlElementTag;
@property (readonly, strong, nonatomic) NSString* xmlElementCloseTag;

- (id) initWithXmlElementTag:(NSString*) tag 
          xmlElementCloseTag:(NSString*) xmlElementCloseTag;
          
- (id) initWithXmlElementTag:(NSString*) tag;

+ (id) xmlElement:(NSString*) xmlElementTag 
xmlElementCloseTag:(NSString*) xmlElementCloseTag;

+ (id) xmlElement:(NSString*) name;

- (void) setAttribute:(NSString*) attributeValue forKey:(NSString*) key;
- (void) appendAttribute:(NSString*) attributeValue forKey:(NSString*) key;

- (void) addElement:(FLXmlElement*) element;
  
@end



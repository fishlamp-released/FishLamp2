//
//  FLXmlElement.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDocumentSection.h"
#import "FLDataEncoding.h"

@protocol FLDataEncoder;
@class FLPropertyDescription;
@class FLXmlDocumentBuilder;
@class FLXmlComment;

// This is for WRITING Xml Elements only with the FLXmlDocumentBuilder.
@interface FLXmlElement : FLDocumentSection {
@private
	NSMutableDictionary* _attributes;
    NSString* _openTag;
    NSString* _closeTag;
    id<FLDataEncoding> _dataEncoder;
    FLXmlComment* _comments;
}

@property (readwrite, strong, nonatomic) id<FLDataEncoding> dataEncoder;
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



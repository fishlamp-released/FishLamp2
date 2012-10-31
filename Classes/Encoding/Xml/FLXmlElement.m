//
//  FLXmlElement.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLXmlElement.h"
#import "FLXmlStringBuilder.h"

@interface FLXmlElement ()
@property (readwrite, strong, nonatomic) NSString* openTag;
@property (readwrite, strong, nonatomic) NSString* closeTag;
@end

@implementation FLXmlElement

@synthesize openTag = _openTag;
@synthesize closeTag = _closeTag;

- (id) initWithOpenTag:(NSString*) tag closeTag:(NSString*) closeTag {
    self = [super init];
    if(self) {
        self.openTag = tag;
        self.closeTag = closeTag;
        self.header = [FLStringBuilder stringBuilder];
    }
    return self;
}

- (id) initWithName:(NSString*) tag {
    return [self initWithOpenTag:tag closeTag:tag];
}

+ (id) xmlElement:(NSString*) openTag closeTag:(NSString*) closeTag {
    return FLReturnAutoreleased([[[self class] alloc] initWithOpenTag:openTag closeTag:closeTag]);
}

+ (id) xmlElement:(NSString*) name {
    return FLReturnAutoreleased([[[self class] alloc] initWithOpenTag:name closeTag:name]);
}

#if FL_MRC
- (void) dealloc {
    [_openTag release];
    [_closeTag release];
    [_attributes release];
    [_comments release];
    [super dealloc];
}
#endif

- (void) setAttribute:(NSString*) attributeValue forKey:(NSString*) key {
    if(!_attributes) {
        _attributes = [[NSMutableDictionary alloc] init];
    }
    
    [_attributes setObject:attributeValue forKey:key];
}

- (void) appendAttribute:(NSString*) attributeValue forKey:(NSString*) key {

    if(!_attributes) {
        [self setAttribute:attributeValue forKey:key];
    }
    else {
        NSString* value = [_attributes objectForKey:key];
        if(value) {
            value = [NSString stringWithFormat:@"%@%@", value, attributeValue];
        }

        [_attributes setObject:value forKey:key];
    }
}

- (void) appendSelfToString:(NSMutableString*) string
                 whitespace:(FLWhitespace*) whitespace
                  tabIndent:(NSInteger*) tabIndent {
 
    if(_comments) {
        [_comments appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
    }
    
    [super appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
    
}

- (BOOL) shouldBuildString {
    return YES;
}

// TODO: make special header and footer XML writers??

- (void) willBuildString {

    BOOL isEmpty = self.isEmpty;
    
    NSString* openTag = nil;
    
    if(_attributes && _attributes.count) {
    
        NSMutableString* attributedOpenTag = [NSMutableString stringWithFormat:@"<%@", self.openTag];
    
        for(NSString* key in _attributes) {
            [attributedOpenTag appendFormat:@" %@=\"%@\"", key, [_attributes objectForKey:key]];
        }
        
        if(isEmpty) {
            [attributedOpenTag appendString:@"/>"];
        }
        else {
            [attributedOpenTag appendString:@">"];
        }
        
        openTag = attributedOpenTag;
    }
    else {
        if(isEmpty) {
            openTag = [NSString stringWithFormat:@"<%@/>", self.openTag];
        }
        else {
            openTag = [NSString stringWithFormat:@"<%@>", self.openTag];
        }
    }
    
    self.header = [FLSingleLineToken singleLineToken:openTag];
    
    if(!isEmpty) {
        self.footer = [FLSingleLineToken singleLineToken:[NSString stringWithFormat:@"</%@>", self.closeTag]];
    }
}

- (FLXmlComment*) comments {
    
    if(!_comments) {
        _comments = [FLXmlComment stringBuilder];
    }
    
    return _comments;
}


@end


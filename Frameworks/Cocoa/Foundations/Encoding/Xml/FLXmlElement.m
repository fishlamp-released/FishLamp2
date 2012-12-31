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
@property (readwrite, strong, nonatomic) NSString* xmlElementTag;
@property (readwrite, strong, nonatomic) NSString* xmlElementCloseTag;
@end

@implementation FLXmlElement

@synthesize xmlElementTag = _openTag;
@synthesize xmlElementCloseTag = _closeTag;

- (id) initWithXmlElementTag:(NSString*) xmlElementTag 
          xmlElementCloseTag:(NSString*) xmlElementCloseTag {
          
    self = [super init];
    if(self) {
        self.xmlElementTag = xmlElementTag;
        self.xmlElementCloseTag = xmlElementCloseTag;
        
//        [self addStringBuilder:[FLStringBuilder stringBuilder]];
        
    }
    return self;
}

- (id) initWithXmlElementTag:(NSString*) xmlElementTag {
    return [self initWithXmlElementTag:xmlElementTag xmlElementCloseTag:xmlElementTag];
}

+ (id) xmlElement:(NSString*) xmlElementTag xmlElementCloseTag:(NSString*) xmlElementCloseTag {
    return FLAutorelease([[[self class] alloc] initWithXmlElementTag:xmlElementTag xmlElementCloseTag:xmlElementCloseTag]);
}

+ (id) xmlElement:(NSString*) name {
    return FLAutorelease([[[self class] alloc] initWithXmlElementTag:name xmlElementCloseTag:name]);
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

- (FLXmlComment*) comments {
    
    if(!_comments) {
        _comments = [FLXmlComment xmlComment];
    }
    
    return _comments;
}

- (void) addElement:(FLXmlElement*) element {
    [self addStringBuilder:element];
}

- (NSString*) xmlOpenTag:(BOOL) isEmpty {
    
    if(_attributes && _attributes.count) {
    
        NSMutableString* attributedOpenTag = [NSMutableString stringWithFormat:@"<%@", self.xmlElementTag];
    
        for(NSString* key in _attributes) {
            [attributedOpenTag appendFormat:@" %@=\"%@\"", key, [_attributes objectForKey:key]];
        }
        
        if(isEmpty) {
            [attributedOpenTag appendString:@"/>"];
        }
        else {
            [attributedOpenTag appendString:@">"];
        }
        
        return attributedOpenTag;
    }
    else if(isEmpty) {
        return [NSString stringWithFormat:@"<%@/>", self.xmlElementTag];
    }
    else {
        return [NSString stringWithFormat:@"<%@>", self.xmlElementTag];
    }
    
}

- (NSString*) xmlCloseTag:(BOOL) isEmpty {

    if(!isEmpty) {
        return [NSString stringWithFormat:@"</%@>", self.xmlElementCloseTag];
    }
    return @"";
}

- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString {

    if(_comments) {
        [_comments appendSelfToPrettyString:prettyString];
    }
    
    BOOL isEmpty = !self.hasLines;
    NSInteger tabIndent = self.tabIndent;

    [prettyString appendLine:[self xmlOpenTag:isEmpty] withTabIndent:tabIndent];
    
    [super appendSelfToPrettyString:prettyString];
    
    [prettyString appendLine:[self xmlCloseTag:isEmpty] withTabIndent:tabIndent];
      
      
}      



@end




//
//  FLXmlElement.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLXmlElement.h"
#import "FLXmlDocumentBuilder.h"

@interface FLXmlElement ()
@property (readwrite, strong, nonatomic) NSString* xmlElementTag;
@property (readwrite, strong, nonatomic) NSString* xmlElementCloseTag;
@end

@implementation FLXmlElement

@synthesize xmlElementTag = _openTag;
@synthesize xmlElementCloseTag = _closeTag;
@synthesize dataEncoder = _dataEncoder;

- (id) initWithXmlElementTag:(NSString*) xmlElementTag 
          xmlElementCloseTag:(NSString*) xmlElementCloseTag {
          
    self = [super init];
    if(self) {
        self.xmlElementTag = xmlElementTag;
        self.xmlElementCloseTag = xmlElementCloseTag;
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
    [_dataEncoder release];
    [_openTag release];
    [_closeTag release];
    [_attributes release];
    [_comments release];
    [super dealloc];
}
#endif

- (void) appendFullPath:(NSMutableString*) path {
    if(self.parent) {
        [self.parent appendFullPath:path];
    }

    if(path.length) {
        [path appendFormat:@"/%@", self.xmlElementTag];
    }
    else {
        [path appendString:self.xmlElementTag];
    }
}

- (NSString*) fullPath {
    NSMutableString* fullPath = [NSMutableString string];
    [self appendFullPath:fullPath];
    return fullPath;
}

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
        if(value) {
            [_attributes setObject:value forKey:key];
        }
    }
}

- (FLXmlComment*) comments {
    
    if(!_comments) {
        _comments = [FLXmlComment xmlComment];
    }
    
    return _comments;
}

- (void) addElement:(FLXmlElement*) element {
    [self appendStringFormatter:element];
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
        return [NSString stringWithFormat:@"<%@ />", self.xmlElementTag];
    }
    else {
        return [NSString stringWithFormat:@"<%@>", self.xmlElementTag];
    }
    
}

- (void) appendSelfToStringFormatter:(id<FLStringFormatter>) stringFormatter {

    if(_comments) {
        [stringFormatter appendStringFormatter:_comments];
    }
    
    BOOL hasLines = self.lines.count > 0;
    [stringFormatter appendLine:[self xmlOpenTag:!hasLines]];
    if(hasLines) {
        [stringFormatter indent:^{
            [super appendSelfToStringFormatter:stringFormatter];
        }];

        [stringFormatter appendLine:[NSString stringWithFormat:@"</%@>", self.xmlElementCloseTag]];
    }
}      

@end




//
//	WsdlCodeGenerator.h
//	PackMule
//
//	Created by Mike Fullerton on 8/9/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FLCodeProjectReader.h"
@class FLCodeProject;
@class FLCodeBuilder;
@class FLParsedXmlElement;
@class FLWsdlDefinitions;
@class FLWsdlMessage;
@class FLWsdlPart;
@class FLWsdlElement;
@class FLWsdlCodeArray;
@class FLWsdlCodeEnumType;
@class FLWsdlCodeObject;
@class FLWsdlBinding;
@class FLWsdlPortCodeObject;

@interface FLWsdlCodeProjectReader : NSObject<FLCodeProjectReader> {
@private
    FLCodeProject* _project;
    FLWsdlDefinitions* _wsdlDefinitions;
	NSMutableDictionary* _objects;
    NSMutableDictionary* _enums;
    NSMutableDictionary* _arrays;
    NSMutableDictionary* _declaredTypes;
    NSMutableDictionary* _messages;
    NSMutableDictionary* _bindingObjects;
    NSMutableDictionary* _portObjects;
}

@property (readonly, strong, nonatomic) FLWsdlDefinitions* wsdlDefinitions;

+ (FLWsdlCodeProjectReader*) wsdlCodeReader;

- (FLWsdlMessage*) wsdlMessageForName:(NSString*) name;
- (BOOL) isEnum:(FLWsdlElement*) element;

- (void) addArray:(FLWsdlCodeArray*) array;
//- (FLWsdlCodeArray*) arrayForName:(NSString*) name;

- (void) addCodeEnum:(FLWsdlCodeEnumType*) enumType;
- (FLCodeEnumType*) enumForKey:(NSString*) key;

- (void) addCodeObject:(FLWsdlCodeObject*) object;
- (FLWsdlCodeObject*) codeObjectForClassName:(NSString*) className;

- (BOOL) partTypeIsObject:(FLWsdlPart*) part;
- (NSString*) servicePortLocationFromBinding:(FLWsdlBinding*) binding;

- (FLWsdlPortCodeObject*) portObjectForName:(NSString*) name;

@end

NS_INLINE
NSString* FLDeleteNamespacePrefix(NSString* string) {
    NSRange range = [string rangeOfString:@":"];
    if(range.length) {
        return [string substringFromIndex:range.location + 1];
    }
    return string;
} 

NS_INLINE
NSString* FLStringToKey(NSString* string) {
    return [FLDeleteNamespacePrefix(string) lowercaseString];
}

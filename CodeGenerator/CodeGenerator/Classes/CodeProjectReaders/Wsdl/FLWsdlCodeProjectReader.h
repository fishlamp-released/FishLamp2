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

@interface FLWsdlCodeProjectReader : NSObject<FLCodeProjectReader> {
@private
    FLCodeProject* _project;
    FLWsdlDefinitions* _wsdlDefinitions;
	NSMutableDictionary* _objects;
    NSMutableDictionary* _enums;
    NSMutableDictionary* _arrays;
}
@property (readonly, strong, nonatomic) FLWsdlDefinitions* wsdlDefinitions;

+ (FLWsdlCodeProjectReader*) wsdlCodeReader;

- (FLWsdlMessage*) wsdlMessageForName:(NSString*) name;
- (BOOL) isEnum:(FLWsdlElement*) element;

- (void) addArray:(FLWsdlCodeArray*) array;
- (void) addCodeEnum:(FLWsdlCodeEnumType*) enumType;
- (FLCodeEnumType*) enumForKey:(NSString*) key;

- (void) addCodeObject:(FLWsdlCodeObject*) object;
- (FLWsdlCodeObject*) codeObjectForClassName:(NSString*) className;

- (BOOL) partTypeIsObject:(FLWsdlPart*) part;
- (NSString*) servicePortLocationFromBinding:(FLWsdlBinding*) binding;

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

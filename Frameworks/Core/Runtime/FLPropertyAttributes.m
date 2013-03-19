//
//  FLPropertyAttributes.m
//  FishLampCore
//
//  Created by Mike Fullerton on 3/18/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPropertyAttributes.h"

//https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html

//https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1

typedef enum {
    FLPropertyAttributeReadOnly = 'R',
    FLPropertyAttributeCopy = 'C',
    FLPropertyAttributeRetain = '&',
    FLPropertyAttributeNonAtomic = 'N',
    FLPropertyAttributeCustomGetter = 'G',
    FLPropertyAttributeCustomSetter = 'S',
    FLPropertyAttributeDynamic = 'D',
    FLPropertyAttributeWeak = 'W',
    FLPropertyAttributeEligibleForGarbageCollection = 'P',
    FLPropertyAttributeOldStyleTypeEncoding = 't',
    FLPropertyAttributeType = 'T',
    FLPropertyAttributeTypeDelimeter = ',',
    FLPropertyAttributeIVar = 'V',

    FLPropertyAttributeTypeObject = '@',
    FLPropertyAttributeStructOrObject = '{',
    FLPropertyAttributeArray = '[',
    FLPropertyAttributeUnion = '(',
    
    FLPropertyAttributeIndirect = '^'
} FLPropertyAttribute;

//@interface FLPropertyAttributes : NSObject {
//@private
//    NSString* _propertyName;
//    NSString* _structName;
//    NSString* _customGetter;
//    NSString* _customSetter;
//    NSString* _ivarName;
//    NSString* _className;
//    NSString* _selectorName;
//    
//    FLPropertyAttributes_t _attributes;    
//}
//- (id) initWithProperty:(objc_property_t) property;
//
//@property (readonly, assign, nonatomic) FLPropertyAttributes_t info;
//
//@property (readonly, strong, nonatomic) NSString* propertyName;
//@property (readonly, strong, nonatomic) NSString* structName;
//@property (readonly, assign, nonatomic) NSString* customGetter;
//@property (readonly, assign, nonatomic) NSString* customSetter;
//@property (readonly, assign, nonatomic) NSString* ivarName;
//@property (readonly, assign, nonatomic) NSString* className;
//@property (readonly, assign, nonatomic) NSString* selectorName;
//@end
//

//
//
//@implementation FLPropertyAttributes
//
//@synthesize propertyName = _propertyName;
//@synthesize info = _info;
//@synthesize className = _className;
//@synthesize structName = _structName;
//@synthesize customGetter = _customGetter;
//@synthesize customSetter = _customSetter;
//@synthesize ivarName = _ivarName;
//@synthesize selectorName = _selectorName;
//
//
////- (id) initWithPropertyAttributes:(FLPropertyAttributes_t) attributes {
////	self = [super init];
////	if(self) {
////		_info = attributes.info;
////        _propertyName = [[NSString alloc] initWithCString:attributes.propertyName encoding:NSASCIIStringEncoding];
////        _structName = FLCreateStringFromSubString(attributes.structName);
////        _customGetter = FLCreateStringFromSubString(attributes.customGetter);
////        _customSetter = FLCreateStringFromSubString(attributes.customSetter);
////        _ivarName = FLCreateStringFromSubString(attributes.ivar);
////        _className = FLCreateStringFromSubString(attributes.className);
////        _selectorName = FLCreateStringFromSubString(attributes.selectorName);
////    }
////	return self;
////}
//
//- (id) initWithProperty(objc_property_t) property {
//    self = [super init];
//    if(self) {
//        _attributes = FLParsePropertyAttributeString(attributeStringCopy, property);
//    }
//    
//    return self;
//}
//
//- (void) dealloc {
//    free(_attributes.encodedAttributes);
//
//#if FL_MRC
//    [_selectorName release];
//    [_propertyName release];
//    [_ivarName release];
//    [_structName release];
//    [_customGetter release];
//    [_customSetter release];
//    [_className release];
//    
//    [super dealloc];
//#endif
//}
//
//
//@end


NS_INLINE
BOOL FLSetPropertyInfoBits(FLPropertyAttributes_t* attributes, char c) {

    switch(c) {
        
    // set attributes bits.
        case FLPropertyAttributeCopy:       
            attributes->copy = 1;        
            break;
        
        case FLPropertyAttributeReadOnly:   
            attributes->readonly = 1;    
            break;
        
        case FLPropertyAttributeTypeDelimeter: 
            // skip
            break;
        
        case FLPropertyAttributeNonAtomic:
            attributes->nonatomic = 1;
            break;
        
        case FLPropertyAttributeRetain: 
            // set by reference? 
            // only seems to be on readwrite properties that have a setter for an object?
            attributes->retain = 1;
        break;
        
        case FLPropertyAttributeEligibleForGarbageCollection:   
            attributes->eligible_for_gc = 1;
            break;
            
        case FLPropertyAttributeType:
            // skip
        break;
        
        case FLPropertyAttributeWeak:
            attributes->weak = 1;
            break;
            
        case FLPropertyAttributeDynamic:
            attributes->dynamic = 1;
            break;

        case FLPropertyAttributeIndirect:
            attributes->indirect_count++;
            break;
            
        default:
            return NO;
            break;
    }
    
    return YES;
} 

void FLParsePropertyAttributes(FLPropertyAttributes_t* attributes) {

    const char* str = attributes->encodedAttributes;
    
	while(*str != 0) {
        char c = *str++;
        
        if(FLSetPropertyInfoBits(attributes, c)) {
            continue;
        }
        
        switch(c) {
        // parse sub strings
        
            case FLPropertyAttributeCustomGetter:
                break;
                
            case FLPropertyAttributeCustomSetter:
                break;
            
            case FLPropertyAttributeTypeObject:
                attributes->is_object = 1;
                if(*str == '\"') {
                    attributes->className = FLCharStringFromCString(++str, '\"');
                    str += (attributes->className.length + 1);
                }
            break;
            
            // enclosed encoded object or struct
            case FLPropertyAttributeStructOrObject: {
            
                // TODO: parse nested structs?? T{CGRect={CGPoint=dd}{CGSize=dd}},N,V_frame
                // For now just eat the inner ones.
            
                
                attributes->structName = FLCharStringFromCString(str, '=');
                str += (attributes->structName.length);

                int bracket_count = 1;
                while(*str++ && bracket_count > 0) {
                    if(*str == '{') {
                        ++bracket_count;
                    }
                    else if(*str == '}') {
                        --bracket_count;
                    }
                }
            }
            break; 

            case FLPropertyAttributeIVar: 
                attributes->ivar = FLCharStringFromCString(str, 0);
                str += attributes->ivar.length;
                goto done;
            break;
            
            case ':':
            case 'b':
            case '#':
                FLAssertFailed_v(@"unsupported type: %c", c);
                break;
            
            // array
            case FLPropertyAttributeArray: {
                // TODO parse array type and size.
                attributes->is_array = 1;
                
                FLCharString ignore = FLCharStringFromCString(str, ']');
                str += (ignore.length + 1);
            }
            break;
            
            case FLPropertyAttributeUnion: {
                attributes->is_union = 1;

                attributes->unionName = FLCharStringFromCString(str, '=');
                str += (attributes->unionName.length);
                
                int bracket_count = 1;
                while(*str++) {
                    if(*str == '(') {
                        ++bracket_count;
                    }
                    if(*str == ')') {
                        --bracket_count;
                    }
                    
                    if(bracket_count == 0) {
                        break;
                    }
                }
            }
            break;
                        
        }
        
    }

done:;

}

void FLPropertyAttributesDecode(objc_property_t property, FLPropertyAttributes_t* attributes, BOOL withCopy) {
    FLAssertNotNil_(property);
    FLAssertNotNil_(attributes);
    
    if(attributes && property) {
        memset(attributes, 0, sizeof(FLPropertyAttributes_t));
    
        attributes->propertyName = property_getName(property);
        attributes->property = property;
        attributes->encodedAttributes = property_getAttributes(property);

        if(withCopy) {
            attributes->needs_free = YES;
            attributes->propertyName = FLCStringCopy(attributes->propertyName);
            attributes->encodedAttributes = FLCStringCopy(attributes->encodedAttributes);
        }
       
        FLParsePropertyAttributes(attributes);
    }
}

void FLPropertyAttributesDecodeWithCopy(objc_property_t property, FLPropertyAttributes_t* attributes) {
    FLPropertyAttributesDecode(property, attributes, YES);
}

void FLPropertyAttributesDecodeWithNoCopy(objc_property_t property, FLPropertyAttributes_t* attributes) {
    FLPropertyAttributesDecode(property, attributes, NO);
}

void FLPropertyAttributesFree(FLPropertyAttributes_t* attributes) {
    if(attributes && attributes->needs_free) {
        if(attributes->encodedAttributes) {
            free((void*)attributes->encodedAttributes);
        }
        if(attributes->propertyName) {
            free((void*)attributes->propertyName);
        }
        memset(attributes, 0, sizeof(FLPropertyAttributes_t));
    }
}

NSString* FLPropertyNameFromAttributes(FLPropertyAttributes_t attributes) {
    return [NSString stringWithCString:attributes.propertyName encoding:NSASCIIStringEncoding];
}



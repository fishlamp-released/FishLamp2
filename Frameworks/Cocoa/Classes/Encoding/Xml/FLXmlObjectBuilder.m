//
//	FLXmlObjectBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLXmlObjectBuilder.h"
#import "FLBase64Encoding.h"
#import "FLDataEncoder.h"
#import "FLObjectDescriber.h"
#import "FLObjectDescriber+FLXmlObjectBuilder.h"

#if OLD
@interface FLXmlObjectBuilder ()
- (id) inflatePropertyObject:(FLPropertyDescriber*) propertyDescriber withElement:(FLParsedItem*) element;
- (void) addPropertiesToModelObject:(id) object withElement:(FLParsedItem*) element;
@end
#endif

@implementation FLXmlObjectBuilder
@synthesize decoder = _decoder;

- (id) init {
    return [self initWithDataDecoder:[FLDataEncoder dataEncoder]];
}

- (id) initWithDataDecoder:(id<FLDataDecoding>) decoder {
    self = [super init];
    if(self) {
        _decoder = FLRetain(decoder);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_decoder release];
    [super dealloc];
}
#endif

+ (id) xmlObjectBuilder:(id<FLDataDecoding>) decoder {
    return FLAutorelease([[[self class] alloc] initWithDataDecoder:decoder]);
}

+ (id) xmlObjectBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLParsedItem*) findElementForBuilding:(NSString*) objectName inParentElement:(FLParsedItem*) parentElement {

    if(FLStringsAreEqual(parentElement.elementName, objectName)) {
        return parentElement;
    }

    FLParsedItem* subElement = [parentElement elementForElementName:objectName];
    if(subElement) {
        return subElement;
    }

    FLThrowErrorCodeWithComment(NSCocoaErrorDomain, NSFileNoSuchFileError, @"XmlObjectBuilder: \"%@\" not found in \"%@\"", objectName, parentElement.elementName);

    return nil;
}
@end


//
//- (id) buildObjectForClass:(Class) objectClass withXmlElement:(FLParsedItem*) element {
//    
//    FLAssertNotNil(self.decoder);
//    FLAssertNotNil(element);
//    FLAssertNotNil(objectClass);
//
//    FLObjectDescriber* objectDescriber = [objectClass objectDescriber];
//    return [objectDescriber xmlObjectBuilder:self inflateObjectWithXml:element];
//}
//- (void) inflateElement:(FLParsedItem*) element 
//              intoArray:(NSMutableArray*) newArray
//           propertyDescriber:(FLPropertyDescriber*) propertyDescriber {
//
//    FLAssertNotNil(newArray);
//    FLAssertNotNil(propertyDescriber);
//  //  FLConfirmNotNilWithComment(propertyDescriber.subtypes, @"expecting an array propertyDescriber");
//
//    for(id elementName in element.elements) {
//        id elementOrArray = [element.elements objectForKey:elementName];
//
//        FLPropertyDescriber* arrayType = [propertyDescriber containedTypeForName:elementName];
//        
//        FLConfirmNotNilWithComment(arrayType, @"arrayType for element \"%@\" not found", elementName);
//        
//        if([elementOrArray isArray]) {
//            for(FLParsedItem* child in elementOrArray) {			
//                [newArray addObject:[self inflatePropertyObject:arrayType withElement:child]];
//            }
//        }
//        else {
//            FLAssert([elementOrArray isKindOfClass:[FLParsedItem class]]);
//            id value = [self inflatePropertyObject:arrayType withElement:elementOrArray];
//            if(value) {
//                [newArray addObject:value];
//            }
//            else {
//                FLLog(@"Unable to inflate xml element %@:%@", elementName, [elementOrArray description]);
//            }
//        }
//    }
//}
//
//- (id) inflatePropertyObject:(FLPropertyDescriber*) property 
//                 withElement:(FLParsedItem*) element  {
//                                
//    FLAssertNotNil(property);
//    
//    if([property representsModelObject]) {
//        id object = [property createRepresentedObject];
//        
//        [self addPropertiesToModelObject:object withElement:element];
//        return object;
//        
//        // NOTE: what if there is a value?? 
//        
//    }
//    else if([element value]) {
//        id<FLStringEncoder> encoder = [property objectEncoder];
//        FLAssertNotNilWithComment(encoder, @"no encoder found for property: %@", property.propertyName);
//
//        if(encoder) {
//            id object = [self.decoder decodeDataFromString:[element value] forType:encoder];
//            
//            FLAssertNotNilWithComment(object,
//                    @"object not expanded for %@:%@", [element elementName], [element value]);
//            
//            return object;
//        }
//    }
//    
//    return nil;
//}
//
//
//- (void) addPropertiesToModelObject:(id) object 
//                        withElement:(FLParsedItem*) element {
//    
//    FLAssertNotNil(object);
//    FLAssert([[object class] isModelObject]);
//    
//    FLObjectDescriber* typeDesc = [[object class] objectDescriber];
//
//    for(id elementName in element.elements) {
//        
//        FLPropertyDescriber* propertyDescriber = [typeDesc propertyForName:elementName];
//        if(!propertyDescriber) {
//            FLLog(@"object builder skipped missing propertyDescriber named: %@", elementName);
//            continue;
//        }
//        
//        // decide if the property we're inflating is an object or an array
//        
//        if(propertyDescriber.representsArray) {
//            // we need to inflate an array
//            // we need to build the array either from a parsedXML element, or an array of parsedXML elements.
//            
//            id elementOrArray = [element.elements objectForKey:elementName];
//
//            NSMutableArray* array = [NSMutableArray array];
//
//            if([elementOrArray isArray]) {
//            
//            // we're building array from array of xmlElements
//            
//                for(FLParsedItem* child in elementOrArray) {
//                    [self inflateElement:child
//                               intoArray:array 
//                       propertyDescriber:propertyDescriber];
//                                
//                }
//            }
//            else {
//            
//            // we're building the array from an xmlElement
//            
//                id xmlElement = [element.elements objectForKey:elementName];
//                FLAssert([xmlElement isKindOfClass:[FLParsedItem class]]);
//                
//                [self inflateElement:xmlElement
//                           intoArray:array 
//             propertyDescriber:propertyDescriber];
//            
//            }
//        
//            if(array.count) {
//                [object setValue:array forKey:elementName];
//            }
//        }
//        else {
//        
//        // we're inflating a single object
//        
//            id xmlElement = [element.elements objectForKey:elementName];
//            FLAssert([xmlElement isKindOfClass:[FLParsedItem class]]);
//            
//            id newObject = [self inflatePropertyObject:propertyDescriber 
//                                           withElement:xmlElement];
//        
//            if(newObject) {
//                [object setValue:newObject forKey:elementName];
//            }
//        }
//        
//        
//    }
//}
//
//- (FLParsedItem*) willBuildObjectsWithXML:(FLParsedItem*) element {
//    return element;
//}
//
//- (id) buildObjectWithXmlElement:(FLParsedItem*) element 
//             withObjectDescriber:(FLObjectDescriber*) objectDescriber {
//    
//    FLAssertNotNil(self.decoder);
//    FLAssertNotNil(element);
//    FLAssertNotNil(objectDescriber);
//
//    Class objectClass = objectDescriber.objectClass;
//
//    if([objectClass isModelObject]) {
//        id rootObject = FLAutorelease([[objectClass alloc] init]);
//        FLAssertNotNilWithComment(rootObject, @"unabled to create object of type: %@", NSStringFromClass(objectClass));
//        
//        [self addPropertiesToModelObject:rootObject withElement:element];
//        return rootObject;
//    }
//    
//    // else we're a simple type, like a string.
//    
//    id<FLStringEncoder> encoder = [objectClass objectEncoder];
//    FLAssertNotNilWithComment(encoder, @"no encoder found for class: %@", NSStringFromClass(objectClass));
//    if(!encoder) {
//        return nil;
//    }
//    
//    id object = [self.decoder decodeDataFromString:[element value] forType:encoder];
//    FLAssertNotNil(object);
//
//    return object;
//}
//#endif
//




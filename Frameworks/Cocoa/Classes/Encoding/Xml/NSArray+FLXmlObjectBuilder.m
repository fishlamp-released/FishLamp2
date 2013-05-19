//
//  NSArray+FLXmlObjectBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "NSArray+FLXmlObjectBuilder.h"
#import "FLXmlObjectBuilder.h"
#import "FLParsedItem.h"
#import "FLModelObject.h"
#import "FLPropertyDescriber+XmlObjectBuilder.h"

@implementation NSArray (FLXmlObjectBuilder) 

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

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
arrayWithElementContents:(FLPropertyDescriber*) propertyDescriber {

    NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:self.count];

    // we're building array from array of xmlElements
    
    for(FLParsedItem* element in self) {
        FLPropertyDescriber* elementDescriber = [propertyDescriber containedTypeForName:element.elementName];
        FLConfirmNotNilWithComment(elementDescriber, @"arrayType for element \"%@\" not found", element.elementName);
        
        id object = [elementDescriber xmlObjectBuilder:builder inflateObjectWithElement:element];
        FLAssertNotNil(object);
        
        [newArray addObject:object];                    
    }
    
    return newArray;
}

@end

@implementation NSObject (FLLameWorkaround)
- (BOOL) isArray {
    return NO;
}
@end

@implementation NSArray (FLLameWorkaround)
- (BOOL) isArray {
    return YES;
}
@end

@implementation FLParsedItem (FLXmlObjectBuilder)

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
arrayWithElementContents:(FLPropertyDescriber*) propertyDescriber {

    NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:self.elements.count];
    
    for(id elementOrArray in [self.elements objectEnumerator]) {
        
        if([elementOrArray isArray]) {
            FLAssert([elementOrArray isKindOfClass:[NSArray class]]);

            for(FLParsedItem* child in elementOrArray) {			
                FLPropertyDescriber* arrayType = [propertyDescriber containedTypeForName:child.elementName];
                id object = [arrayType xmlObjectBuilder:builder inflateElementContents:child];
                if(object) {
                    [newArray addObject:object];
                }
                else {
                    FLLog(@"Unable to inflate xml element %@:%@", child.elementName, [child description]);
                }
            }
        }
        else {
            FLAssert([elementOrArray isKindOfClass:[FLParsedItem class]]);

            FLPropertyDescriber* arrayType = [propertyDescriber containedTypeForName:[elementOrArray elementName]];
            if(!arrayType) {
                FLLog(@"Array type for %@:%@ not found", self.elementName, [elementOrArray elementName]);
            }
                    
            id object = [arrayType xmlObjectBuilder:builder inflateElementContents:elementOrArray];
            if(object) {
                [newArray addObject:object];
            }
            else {
                FLLog(@"Unable to inflate xml element %@:%@", [elementOrArray elementName], [elementOrArray description]);
            }
        }
    }
        
    return newArray;
}

@end



//
//  FLObjcTypeRegistry.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcTypeRegistry.h"
#import "FLObjcCodeGeneratorHeaders.h"

#import "FLCodeProject.h"
#import "FLCodeDataTypeCollection.h"
#import "FLCodeEnumType.h"
#import "FLCodeTypeDefinition.h"
#import "FLCodeGeneratorOptions.h"
#import "FLCodeObject.h"
#import "FLCodeMethod.h"
#import "FLCodeGeneratorErrors.h"

@interface FLObjcTypeRegistry ()
//@property (readwrite, strong, nonatomic) NSDictionary* knownTypeAliases;
@end

@implementation FLObjcTypeRegistry
//@synthesize knownTypeAliases = _parseableTypes;

+ (id) objcTypeRegistry {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) hasType:(FLObjcType*) type {
    return [self hasObjcName:type.typeName];
}

- (void) addType:(FLObjcType*) type {
    [self addObject:type forObjcName:type.typeName];
}

- (void) replaceType:(FLObjcType*) type {
    [self replaceObject:type forObjcName:type.typeName];
}

- (id) typeForClass:(Class) aClass {
    return [self objectForClass:aClass];
}

- (id) typeForKey:(NSString*) key {
    return [self objectForKey:key];
}

- (id) typeForName:(FLObjcName*) name {
    return [self objectForObjcName:name];
}

//- (FLObjcType*) objectForKey:(NSString*) typeName {
//   typeName = [typeName stringByReplacingOccurrencesOfString:@"*" withString:@""];
//   
//   FLObjcType* type = [super objectForKey:typeName];
//   if(type == nil) {
//        NSString* newType = [_parseableTypes objectForKey:[typeName lowercaseString]];
//        if(newType) {
//            type = [super objectForKey:newType];
//        }
//   }
//   
//   if(!type) {
//        FLThrowCodeGeneratorError(FLCodeGeneratorErrorCodeUnknownType, @"Unknown type \"%@\"", typeName);
//   }
//   
//   return type;
//}

//#if FL_MRC
//- (void) dealloc {
//	[_parseableTypes release];
//	[super dealloc];
//}
//#endif

@end

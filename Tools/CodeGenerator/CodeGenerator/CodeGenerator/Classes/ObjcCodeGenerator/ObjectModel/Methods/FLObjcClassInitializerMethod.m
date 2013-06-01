//
//  FLObjcClassInitializerMethod.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcClassInitializerMethod.h"
#import "FLObjcCodeGeneratorHeaders.h"

@implementation FLObjcClassInitializerMethod

- (id) initWithTypeIndex:(FLObjcTypeIndex *)index {	
	self = [super initWithTypeIndex:index ];
	if(self) {
		
	}
	return self;
}

- (void) didMoveToObject:(FLObjcObject*) object {
    [super didMoveToObject:object];

    self.methodName = [FLObjcMethodName objcMethodName:self.parentObject.objectName.identifierName];
    self.returnType = self.parentObject.objectType;
    self.isStatic = YES;
    
    FLObjcStringStatement* statement = [FLObjcStringStatement objcStringStatement];
    [statement.string appendLine:@"return FLAutorelease([[[self class] alloc] init]);"];
    [self addStatement:statement];
    
//    [self.parentObject addDependency:self.ivar.variableType];
//    [self.parentObject addDependency:self.propertyType];
//    [self.parentObject addIvar:self.ivar];
//    
//    if(self.containerTypes && self.containerTypes.count) {
//        [self.parentObject addDependency:[self.typeIndex objcTypeForClass:[FLObjectDescriber class]]];
//     
//        for(FLObjcContainerSubType* subType in self.containerTypes) {
//            [self.parentObject addDependency:subType.objcType];
//        }
//    }    
    
}

@end

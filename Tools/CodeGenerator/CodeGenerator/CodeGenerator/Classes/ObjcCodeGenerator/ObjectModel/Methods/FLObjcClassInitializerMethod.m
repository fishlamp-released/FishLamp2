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

- (id) initWithProject:(FLObjcProject *)project {	
	self = [super initWithProject:project ];
	if(self) {
		
	}
	return self;
}

- (void) didMoveToObject:(FLObjcObject*) object {
    [super didMoveToObject:object];

    self.methodName = [FLObjcMethodName objcMethodName:self.parentObject.objectName.identifierName];
    self.returnType = self.parentObject.objectType;
    self.isStatic = YES;
    
    [self.code appendReturnValue:@"FLAutorelease([[[self class] alloc] init])"];
    
    
//    [self.parentObject addDependency:self.ivar.variableType];
//    [self.parentObject addDependency:self.propertyType];
//    [self.parentObject addIvar:self.ivar];
//    
//    if(self.containerTypes && self.containerTypes.count) {
//        [self.parentObject addDependency:[self.project typeForKey:[FLObjectDescriber class]]];
//     
//        for(FLObjcContainerSubType* subType in self.containerTypes) {
//            [self.parentObject addDependency:subType.objcType];
//        }
//    }    
    
}

@end

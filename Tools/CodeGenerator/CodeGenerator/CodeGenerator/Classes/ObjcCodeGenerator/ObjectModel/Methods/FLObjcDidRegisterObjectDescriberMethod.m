//
//  FLObjcDidRegisterObjectDescriberMethod.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcDidRegisterObjectDescriberMethod.h"
#import "FLObjcCodeGeneratorHeaders.h"

#import "FLObjectDescriber.h"

@implementation FLObjcDidRegisterObjectDescriberMethod

- (id) initWithProject:(FLObjcProject *)project {	
	self = [super initWithProject:project ];
	if(self) {
        self.returnType = [FLObjcVoidType objcVoidType];
        self.methodName = [FLObjcMethodName objcMethodName:@"didRegisterObjectDescriber"];
        self.isStatic = YES;
        self.isPrivate = YES;
                
        FLObjcParameterName* parameterName = [FLObjcParameterName objcParameterName:@"describer"];
        FLObjcType* type = [project.typeRegistry typeForClass:[FLObjectDescriber class]];
        
        FLObjcParameter* parameter = [FLObjcParameter objcParameter:parameterName parameterType:type key:@"describer"];
        [self addParameter:parameter];
    }
    return self;
}

+ (id) objcDidRegisterObjectDescriberMethod:(FLObjcProject*) project {
    return FLAutorelease([[[self class] alloc] initWithProject:project]);
}

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    
    FLAssertNotNil(self.parentObject);
    FLAssertNotNil(codeBuilder);
    
    BOOL foundContainerTypes = NO;
    for(FLObjcProperty* property in [self.parentObject.properties objectEnumerator]) {
        NSArray* containerTypes = property.containerTypes;
        if(containerTypes && containerTypes.count) {
            foundContainerTypes = YES;
        }
    }
    
    if(foundContainerTypes) {
        FLObjcStringStatement* statement = nil;
        for(FLObjcProperty* property in [self.parentObject.properties objectEnumerator]) {
            NSArray* containerTypes = property.containerTypes;
            if(containerTypes && containerTypes.count) {
                
                if(!statement) {
                    statement = [FLObjcStringStatement objcStringStatement]; 
                }
                
                for(FLObjcContainerSubType* subType in containerTypes) {
                    NSString* propertyDescriber = [NSString stringWithFormat:@"[FLPropertyDescriber propertyDescriber:@\"%@\" propertyClass:[%@ class]]", subType.subTypeName, subType.objcType.generatedObjectClassName];
                
                    
                
                    [statement.string appendLineWithFormat:@"[describer addContainerType:%@ forContainerProperty:@\"%@\"];", propertyDescriber, property.propertyName.generatedName];
                }
            }
        }

        // only write the method if we have content
        if(statement) {
            [self addStatement:statement];
            [super writeCodeToSourceFile:file withCodeBuilder:codeBuilder];
        }
    }
}


@end

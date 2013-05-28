//
//  FLObjcDidRegisterObjectDescriberMethod.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcDidRegisterObjectDescriberMethod.h"
#import "FLObjcProperty.h"
#import "FLObjcType.h"
#import "FLObjcName.h"
#import "FLObjectDescriber.h"
#import "FLObjcTypeIndex.h"
#import "FLObjcVariable.h"
#import "FLObjcObject.h"
#import "FLObjcCodeBuilder.h"

@implementation FLObjcDidRegisterObjectDescriberMethod

- (id) initWithTypeIndex:(FLObjcTypeIndex *)index {	
	self = [super initWithTypeIndex:index ];
	if(self) {
        self.returnType = [FLObjcVoidType objcVoidType];
        self.methodName = [FLObjcMethodName objcMethodName:@"didRegisterObjectDescriber"];
        self.isStatic = YES;
        self.isPrivate = YES;
                
        FLObjcParameterName* parameterName = [FLObjcParameterName objcParameterName:@"describer"];
        FLObjcType* type = [index objcTypeForClass:[FLObjectDescriber class]];
        
        FLObjcParameter* parameter = [FLObjcParameter objcParameter:parameterName parameterType:type key:@"describer"];
        [self addParameter:parameter];
    }
    return self;
}

+ (id) objcDidRegisterObjectDescriberMethod:(FLObjcTypeIndex*) typeIndex {
    return FLAutorelease([[[self class] alloc] initWithTypeIndex:typeIndex]);
}

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    
    BOOL foundContainerTypes = NO;
    for(FLObjcProperty* property in [self.parentObject.properties objectEnumerator]) {
        NSArray* containerTypes = property.containerTypes;
        if(containerTypes && containerTypes.count) {
            foundContainerTypes = YES;
        }
    }
    
    if(foundContainerTypes) {
        [super writeCodeToSourceFile:file withCodeBuilder:codeBuilder];
        [codeBuilder scope:^{
    
            for(FLObjcProperty* property in [self.parentObject.properties objectEnumerator]) {
                NSArray* containerTypes = property.containerTypes;
                if(containerTypes && containerTypes.count) {
                    
                    for(FLObjcContainerSubType* subType in containerTypes) {
                        NSString* propertyDescriber = [NSString stringWithFormat:@"[FLPropertyDescriber propertyDescriber:@\"%@\" propertyClass:[%@ class]]", subType.subTypeName, subType.objcType.generatedName];
                    
                        [codeBuilder appendLineWithFormat:@"[describer addContainerType:%@ forContainerProperty:@\"%@\"];", propertyDescriber, property.propertyName.generatedName];
                    }
                }
            }
                            
        }];
        
    }
    

}


@end

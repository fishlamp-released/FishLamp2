//
//  FLObjcConstructor.m
//  FishLampCodeGenerator
//
//  Created by Mike Fullerton on 6/8/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcConstructor.h"

#import "FLCodeConstructor.h"
#import "FLObjcCodeGeneratorHeaders.h"

@implementation FLObjcConstructor

- (id) initWithProject:(FLObjcProject*) project {	
	self = [super initWithProject:project];
	if(self) {
		
	}
	return self;
}

+ (id) objcConstructor:(FLObjcProject*) project {
    return FLAutorelease([[[self class] alloc] initWithProject:project]);
}

- (void) configureWithInputConstructor:(FLCodeConstructor*) constructor 
                            withObject:(FLObjcObject*) object {

    self.isStatic = YES;
    self.methodName = [FLObjcMethodName objcMethodName:object.objectName.generatedName];
    self.returnType = [self.project.typeRegistry typeForKey:@"id"];

//    for(FLCodeLine* codeLine in codeMethod.codeLines) {
//        [self.code appendCodeElement:codeLine withProject:self.project];
//    }

}

@end

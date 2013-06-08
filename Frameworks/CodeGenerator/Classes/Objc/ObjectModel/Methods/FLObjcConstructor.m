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

//    self.isPrivate = codeMethod.isPrivate;
//    self.isStatic = codeMethod.isStatic;
//    self.methodName = [FLObjcMethodName objcMethodName:codeMethod.name];
//    
//    if(FLStringIsNotEmpty(codeMethod.returnType)) {
//        self.returnType = [self.project.typeRegistry typeForKey:codeMethod.returnType];
//    }
//
//    for(FLCodeLine* codeLine in codeMethod.codeLines) {
//        [self.code appendCodeLine:codeLine withProject:self.project];
//    }

}

@end

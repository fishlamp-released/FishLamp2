//
//  FLObjcBoolType.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcBoolType.h"
#import "FLObjcCodeGeneratorHeaders.h"


@implementation FLObjcBoolType 

- (id) init {	
	return [super initWithTypeName:[FLObjcImportedName objcImportedName:@"BOOL"]  importFileName:nil];
}

+ (id) objcBoolType {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) isObject {
    return NO;
}

//+ (id) objcNumberValueType:(NSString*) numberType {
//    return FLAutorelease([[[self class] alloc] init]);
//}
@end

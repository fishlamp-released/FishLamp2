//
//  FLWsdlCodeArrayType.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlCodeArrayType.h"
#import "FLWsdlCodeProjectReader.h"

@implementation FLWsdlCodeArrayType

- (id) initWithArrayName:(NSString*) name
                typeName:(NSString*) typeName {
	self = [super init];
	if(self) {
        self.name = name;
        self.typeName = typeName;
	}
	return self;
}

- (void) setName:(NSString*) name {
    [super setName:FLDeleteNamespacePrefix(name)];
    FLConfirmStringIsNotEmptyWithComment(self.name, @"array type needs a identifier");
}

- (void) setTypeName:(NSString*) typeName {
    [super setTypeName:FLDeleteNamespacePrefix(typeName)];
    FLConfirmStringIsNotEmptyWithComment(self.typeName, @"array type needs a typeName");
}

+ (id) wsdlCodeArrayType:(NSString*) name typeName:(NSString*) typeName {
    return FLAutorelease([[[self class] alloc] initWithArrayName:name typeName:typeName]);
}


@end

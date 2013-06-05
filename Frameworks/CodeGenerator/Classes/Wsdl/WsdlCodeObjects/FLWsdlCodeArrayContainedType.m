//
//  FLWsdlCodeArrayContainedType.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWsdlCodeArrayContainedType.h"
#import "FLWsdlCodeProjectReader.h"

@implementation FLWsdlCodeArrayContainedType

- (id) initWithTypeName:(NSString*) typeName
                identifier:(NSString*) identifier {
	self = [super init];
	if(self) {
        self.name = identifier;
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

+ (id) wsdlCodeArrayContainedType:(NSString*) typeName identifier:(NSString*) identifier {
    return FLAutorelease([[[self class] alloc] initWithTypeName:typeName identifier:identifier]);
}


@end

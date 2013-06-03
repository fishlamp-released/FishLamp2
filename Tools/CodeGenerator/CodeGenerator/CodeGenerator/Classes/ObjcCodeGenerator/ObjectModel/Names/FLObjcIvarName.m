//
//  FLObjcIvarName.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcIvarName.h"

@implementation FLObjcIvarName 
+ (id) objcIvarName:(NSString*) ivarName {
    return FLAutorelease([[[self class] alloc] initWithIdentifierName:ivarName prefix:@"_" suffix:nil]);
}

- (NSString*) generatedName {
    return [NSString stringWithFormat:@"%@%@%@", self.prefix, [self.identifierName stringWithLowercaseFirstLetter], self.suffix];
}

@end

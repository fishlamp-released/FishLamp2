//
//  FLObjcCodeLines.m
//  FishLampCodeGenerator
//
//  Created by Mike Fullerton on 6/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeLines.h"
#import "FLCodeElementsAll.h"

#import "FLObjcType.h"
#import "FLObjcCodeBuilder.h"
#import "FLObjcProject.h"
#import "FLObjcTypeRegistry.h"
#import "FLObjcCodeGeneratorHeaders.h"

@implementation NSObject (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return nil;
}
@end

@implementation FLObjcCodeBuilder (FLObjcCodeLine)

- (void) appendCodeElement:(FLCodeElement*) codeElement
               withProject:(FLObjcProject*) project {

    [self appendLine:[codeElement stringForObjcProject:project]];
}
@end


@implementation NSString (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return self;
}
@end

@implementation FLCodeElement (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return nil;
}
@end


@implementation FLCodeString (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return [NSString stringWithFormat:@"@\"%@\"", [self.code stringForObjcProject:project]];

}
@end

@implementation FLCodeCreateObject (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    FLObjcType* theType = [project.typeRegistry typeForKey:[self.code stringForObjcProject:project]];
    return [NSString stringWithFormat:@"FLAutorelease([[%@ alloc] init])", theType.generatedName];
}
@end

@implementation FLCodeReturn (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return [NSString stringWithFormat:@"return %@", [self.code stringForObjcProject:project]];
}
@end

@implementation FLCodeClassName (FLObjcCodeLine)

- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    FLObjcClassName* className = [FLObjcClassName objcClassName:[self.code stringForObjcProject:project] prefix:project.classPrefix];
    return [className generatedName];
}

@end
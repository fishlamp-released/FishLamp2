//
//  FLObjcCodeLines.m
//  FishLampCodeGenerator
//
//  Created by Mike Fullerton on 6/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeLines.h"

#import "FLObjcType.h"
#import "FLObjcCodeBuilder.h"
#import "FLObjcProject.h"
#import "FLObjcTypeRegistry.h"
#import "FLObjcCodeGeneratorHeaders.h"

@implementation NSString (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return self;
}
@end

@implementation FLCodeLine (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return [NSString stringWithFormat:@"%@;", [self.codeLine stringForObjcProject:project]];
}
@end

@implementation FLObjcCodeBuilder (FLObjcCodeLine)
- (void) appendCodeLine:(FLCodeLine*) codeLine 
            withProject:(FLObjcProject*) project {
    [self appendLine:[codeLine stringForObjcProject:project]];
}
@end

@implementation FLStringCodeLine (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return [NSString stringWithFormat:@"@\"%@\"", [self.codeLine stringForObjcProject:project]];

}
@end

@implementation FLCreateObjectCodeLine (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    FLObjcType* theType = [project.typeRegistry typeForKey:[self.codeLine stringForObjcProject:project]];
    return [NSString stringWithFormat:@"FLAutorelease([[%@ alloc] init])", theType.generatedName];
}
@end

@implementation FLReturnCodeLine (FLObjcCodeLine)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return [NSString stringWithFormat:@"return %@", [self.codeLine stringForObjcProject:project]];
}
@end

@implementation FLClassNameCodeLine (FLObjcCodeLine)

- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    FLObjcClassName* className = [FLObjcClassName objcClassName:[self.codeLine stringForObjcProject:project] prefix:project.classPrefix];
    return [className generatedName];
}

@end
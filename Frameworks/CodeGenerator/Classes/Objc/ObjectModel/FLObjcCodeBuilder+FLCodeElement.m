//
//  FLObjcCodeBuilder+FLCodeElement.m
//  FishLampCodeGenerator
//
//  Created by Mike Fullerton on 6/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeBuilder+FLCodeElement.h"

#import "FLObjcType.h"
#import "FLObjcCodeBuilder.h"
#import "FLObjcProject.h"
#import "FLObjcTypeRegistry.h"
#import "FLObjcCodeGeneratorHeaders.h"

@implementation NSObject (FLObjcCodeWriter)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return nil;
}
@end

@implementation FLObjcCodeBuilder (FLObjcCodeWriter)

- (void) appendCodeElement:(FLCodeElement*) codeElement
               withProject:(FLObjcProject*) project {

    [self appendLine:[codeElement stringForObjcProject:project]];
}
@end


@implementation NSString (FLObjcCodeWriter)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return self;
}
@end

@implementation FLCodeElement (FLObjcCodeWriter)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    FLAssertFailedWithComment(@"this is supposed to be overridden to do something");
    return nil;
}
@end


@implementation FLCodeString (FLObjcCodeWriter)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return [NSString stringWithFormat:@"@\"%@\"", [self.rep stringForObjcProject:project]];

}
@end

@implementation FLCodeCreateObject (FLObjcCodeWriter)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    FLObjcType* theType = [project.typeRegistry typeForKey:[self.rep stringForObjcProject:project]];
    return [NSString stringWithFormat:@"FLAutorelease([[%@ alloc] init])", theType.generatedName];
}
@end

@implementation FLCodeReturn (FLObjcCodeWriter)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    return [NSString stringWithFormat:@"return %@", [self.rep stringForObjcProject:project]];
}
@end

@implementation FLCodeClassName (FLObjcCodeWriter)

- (NSString*) stringForObjcProject:(FLObjcProject*) project {
    FLObjcClassName* className = [FLObjcClassName objcClassName:[self.rep stringForObjcProject:project] prefix:project.classPrefix];
    return [className generatedName];
}

@end

@implementation FLCodeStatement (FLObjcCodeWriter)
- (NSString*) stringForObjcProject:(FLObjcProject*) project {
   return [NSString stringWithFormat:@"%@;", [self.rep stringForObjcProject:project]];
}
@end
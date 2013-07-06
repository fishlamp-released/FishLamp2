//
//  FLObjcNumberValueType.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcNumberValueType.h"
#import "FishLampCodeGeneratorObjects.h"

@implementation FLObjcNumberValueType 

- (NSString*) generatedObjectClassName {
    return @"NSNumber";
}

- (FLCodeElement*) defaultValueForString:(NSString*) string {
    return [FLCodeStatement codeStatement:
                [FLCodeReturn codeReturn:string]];
}

@end

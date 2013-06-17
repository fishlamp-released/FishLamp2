//
//  FLObjcCodeGenerator.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeGenerator.h"
#import "FLObservable.h"

@interface FLObjcCodeGenerator : FLObservable<FLCodeGenerator> {
@private
}

+ (id) objcCodeGenerator;
@end




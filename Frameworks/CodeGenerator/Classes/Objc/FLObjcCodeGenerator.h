//
//  FLObjcCodeGenerator.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeGenerator.h"
#import "FLNotifier.h"

@interface FLObjcCodeGenerator : FLNotifier<FLCodeGenerator> {
@private
}

+ (id) objcCodeGenerator;
@end




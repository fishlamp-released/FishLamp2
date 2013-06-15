//
//	FLCodeGenerator.h
//	PackMule
//
//	Created by Mike Fullerton on 8/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FishLampCocoa.h"

#import "FLObjectModelAll.h"
@class FLCodeGeneratorResult;
@class FLCodeProjectLocation;

#import "FLCodeGeneratorResult.h"
#import "FLCodeGeneratorErrors.h"

@protocol FLCodeGenerator <NSObject>
- (FLCodeGeneratorResult*) generateCodeWithCodeProject:(FLCodeProject*) project fromLocation:(FLCodeProjectLocation*) location;
@end


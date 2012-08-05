//
//  FLCStyleCodeBuilder.h
//  FishLampCore
//
//  Created by Mike Fullerton on 5/26/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

#import "FLCodeBuilder.h"

/// FLCStyleCodeBuilder writes tabbed code with { } braces.

@interface FLCStyleCodeBuilder : FLCodeBuilder {
}
@end


#define FLCCodeScope 'cCod'

@interface FLCStyleCodeFormatter : FLCodeScopeFormatter {}
FLSingletonProperty(FLCStyleCodeFormatter);
@end



//
//  FLColorRange+FLThemes.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 5/24/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLColorRange.h"
#import "FLThemeObjectsEnums.h"

@interface FLColorRange (FLThemes)
+ (FLColorRange*) colorRangeWithColorRangeName:(FLColorRangeEnum) name;
@end

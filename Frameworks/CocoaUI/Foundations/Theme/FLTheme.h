//
//  FLTheme.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObjectDescriber.h"
#import "FLThemeChangedListener.h"

@interface FLTheme : FLSelfDescribingObject {
@private
    NSString* _themeName;
}
@property (readwrite, strong, nonatomic) NSString* themeName;

+ (FLTheme*) currentTheme;
@end

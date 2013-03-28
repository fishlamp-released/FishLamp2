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
#import "FLFontTheme.h"
#import "FLAttributedString.h"

@interface FLTheme : FLSelfDescribingObject {
@private
    NSString* _themeName;
    FLStringDisplayStyle* _applicationTextStyle;
    FLStringDisplayStyle* _headlineTextStyle;
    FLStringDisplayStyle* _bigTextStyle;
    
}
@property (readwrite, strong, nonatomic) NSString* themeName;
@property (readwrite, strong, nonatomic) FLStringDisplayStyle* applicationTextStyle;
@property (readwrite, strong, nonatomic) FLStringDisplayStyle* headlineTextStyle;
@property (readwrite, strong, nonatomic) FLStringDisplayStyle* bigTextStyle;

- (void) applyThemeToObject:(id) object;

+ (FLTheme*) currentTheme;
@end




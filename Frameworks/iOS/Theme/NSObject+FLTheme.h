//
//	NSObject+FLTheme.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLTheme;

typedef void (^FLApplyThemeToObjectBlock)(id object, FLTheme* theme);

@interface NSObject (FLTheme)

@property (readwrite, assign, nonatomic) BOOL wantsApplyTheme;
@property (readwrite, assign, nonatomic) BOOL wasThemed;

// if this is set, the block will be called instead of [self applyTheme] 
// note you can call applyTheme if you want. 
// Watch out for retain cycles and memory leaks when using this. 
// Use object parameter to modify themed object. 
@property (readwrite, copy, nonatomic) FLApplyThemeToObjectBlock onApplyTheme;

- (void) applyThemeIfNeeded;

// override this
- (void) applyTheme:(FLTheme*) theme;
- (void) didApplyTheme;
@end


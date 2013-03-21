//
//  FLThemeChangedListener.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLThemeChangedListener.h"
#import "FLThemeManager.h"

@implementation FLThemeChangedListener

- (id) initWithTarget:(id) target {

	self = [super initWithEventName:FLThemeChangedNotificationKey sender:[FLThemeManager instance] parameterKey:FLCurrentThemeKey];

	if(self) {
        if(target) {
            [self setTarget:target action:@selector(themeDidChange_fl:)];
        }
	}
	return self;
}

- (id) init {
    return [self initWithTarget:nil];
}


+ (id) themeChangedListener:(id) target {
    return FLAutorelease([[[self class] alloc] initWithTarget:target]);
}

+ (id) themeChangedListener {
    return FLAutorelease([[[self class] alloc] init]);
}
@end

@implementation NSObject (FLTheme)

- (void) themeDidChange_fl:(id) theme {

}

@end
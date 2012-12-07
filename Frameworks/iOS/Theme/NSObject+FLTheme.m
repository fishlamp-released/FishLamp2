//
//	NSObject+FLTheme.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLTheme.h"
#import "FLThemeManager.h"
#import <objc/runtime.h>

@interface FLThemeChangeListener : NSObject {
@private
    __weak id _object;
    BOOL _wasThemed;
    BOOL _wantsApplyTheme;
    FLApplyThemeToObjectBlock _applyThemeBlock;
}

@property (readwrite, assign, nonatomic) BOOL wasThemed;
@property (readwrite, assign, nonatomic) BOOL wantsApplyTheme;
@property (readwrite, weak, nonatomic) id object;
@property (readwrite, copy, nonatomic) FLApplyThemeToObjectBlock onApplyTheme;

- (id) initWithObject:(id) object;

- (void) applyTheme;

@end

@interface NSObject (FLThemeChangeListener) 
@property (readwrite, strong, nonatomic) FLThemeChangeListener* themeChangeListener;
@end

static void * const kListenerKey = (void*)&kListenerKey;

@implementation NSObject (FLThemeChangeListener) 

- (FLThemeChangeListener*) _themeChangelistener {
    return objc_getAssociatedObject(self, kListenerKey);
}

- (FLThemeChangeListener*) themeChangeListener {
    FLThemeChangeListener* listener = [self _themeChangelistener];
    if(!listener) {
        listener = FLAutorelease([[FLThemeChangeListener alloc] initWithObject:self]);
        self.themeChangeListener = listener;
    }
    return listener;
}

- (void) setThemeChangeListener:(FLThemeChangeListener*) listener {
    objc_setAssociatedObject(self, kListenerKey, listener, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation NSObject (FLTheme)

- (void) applyTheme:(FLTheme*) theme  {
}

- (void) setWasThemed:(BOOL) wasThemed {
    self.themeChangeListener.wasThemed = wasThemed;
}

- (BOOL) wasThemed {
    return [self _themeChangelistener].wasThemed;
}

- (BOOL) wantsApplyTheme {
    return [self _themeChangelistener].wantsApplyTheme;
}

- (void) setWantsApplyTheme:(BOOL) wantsApplyTheme {
    self.themeChangeListener.wantsApplyTheme = wantsApplyTheme;
}

- (void) applyThemeIfNeeded {
    FLThemeChangeListener* listener = [self _themeChangelistener];
    if(listener && listener.wantsApplyTheme && !listener.wasThemed) {
        [listener applyTheme];
    }
}

- (void) setOnApplyTheme:(FLApplyThemeToObjectBlock) block {
    self.themeChangeListener.onApplyTheme = block;
}

- (FLApplyThemeToObjectBlock) onApplyTheme {
    return [self _themeChangelistener].onApplyTheme;
}

- (void) didApplyTheme {
}

@end


@implementation FLThemeChangeListener

@synthesize object = _object;
@synthesize wasThemed = _wasThemed;
@synthesize wantsApplyTheme = _wantsApplyTheme;
@synthesize onApplyTheme = _applyThemeBlock;

- (void) applyTheme {
    _wasThemed = NO;
    if(self.wantsApplyTheme) {
        id object = self.object;
        if(_applyThemeBlock) {
            _applyThemeBlock(_object, [FLTheme currentTheme]);
        }
        else {
            [object applyTheme:[FLTheme currentTheme]];
        }
        [object didApplyTheme];
        _wasThemed = YES;
    }
}

- (void) _themeDidChange:(id) sender {
    [self applyTheme];
}

- (id) initWithObject:(id) object {
    self = [super init];
    if(self) {
        self.object = object;
        [[NSNotificationCenter defaultCenter] addObserver:self 
            selector:@selector(_themeDidChange:)
            name:FLThemeDidChangeNotification
            object:[FLThemeManager instance]];
    }
    return self;
}

- (void) dealloc {
    _object = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    super_dealloc_();
}

@end
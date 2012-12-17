//
//  FLXcodePlugin.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCocoa.h"

@interface FLXcodePlugin : NSObject {
@private
    NSBundle* _pluginBundle;
}
@property (readonly, strong) NSBundle* pluginBundle;

FLSingletonProperty(FLXcodePlugin);

- (void) pluginDidLoad:(NSBundle *)plugin;
- (NSMenuItem*) insertPluginMenuInMainMenu:(NSString*) title;


@end

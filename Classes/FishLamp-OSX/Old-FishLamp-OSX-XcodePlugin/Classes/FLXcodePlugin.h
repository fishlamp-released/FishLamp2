//
//  FLXcodePlugin.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/9/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

//
//  ZFAboutWindowController.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ZFAboutWindowController : NSWindowController {
@private
    IBOutlet NSTextField* _versionLabel;
    IBOutlet NSView* _backgroundImageView;
    IBOutlet NSButton* _dismissButton;
}

+ (id) aboutWindowController;

@end

//
//  ZFAboutWindowController.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFAboutWindowController.h"
#import "FLAppInfo.h"

#define SIGNUP_URL     @"https://secure.zenfolio.com/zf/signup/plans.aspx"
#define kAboutURL       @"http://www.zenfolio.com/zf/product.aspx"

@interface ZFAboutWindowController ()
//@property (readwrite, strong, nonatomic) IBOutlet NSTextField* versionLabel;
//@property (readwrite, strong, nonatomic) IBOutlet NSView* backgroundImageView;
@end


@implementation ZFAboutWindowController

//@synthesize versionLabel = _versionLabel;
//@synthesize backgroundImageView = _backgroundImageView;

#if FL_MRC
- (void) dealloc {
    [_versionLabel release];
    [_backgroundImageView release];
    [super dealloc];
}
#endif

- (id) init {
    return [self initWithWindowNibName:@"ZFAboutWindowController"];
}

+ (id) aboutWindowController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void)windowDidLoad {
    [super windowDidLoad];
    _versionLabel.stringValue = [NSString stringWithFormat:@"Version %@", [FLAppInfo appVersion]];
    
    [_backgroundImageView sendToBack];
    

    [self.window setDefaultButtonCell:[_dismissButton cell]];
}

- (IBAction)aboutZenfolio:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:kAboutURL]];
}

- (IBAction)signup:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:SIGNUP_URL]];
}

- (IBAction)contactSupport:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://secure.zenfolio.com/zf/contact.aspx"]];
}

//- (IBAction)close:(id)sender {
//    [self close];
//}

@end

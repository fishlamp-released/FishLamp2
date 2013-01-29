//
//  ZFProgressSheet.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 1/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ZFProgressSheet : NSWindowController {
@private
    IBOutlet NSTextField* _progressTextField;
    IBOutlet NSProgressIndicator* _spinner;
    IBOutlet NSProgressIndicator* _progressBar;
    IBOutlet NSButton* _button;
    NSString* _progressString;
    dispatch_block_t _cancelBlock;
}

@property (readwrite, nonatomic, strong) NSString* progressString;
@property (readwrite, copy, nonatomic) dispatch_block_t cancelBlock;

+ (id) progressWindowController;

- (IBAction) respondToCancelButton:(id) sender;

- (void) setValue:(CGFloat) value total:(CGFloat) total;
- (void) incrementValue;


@end

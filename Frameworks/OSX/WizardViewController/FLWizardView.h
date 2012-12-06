//
//  FLWizardView.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FLWizardView : NSView {
@private
    IBOutlet NSButton* _nextButton;
    IBOutlet NSButton* _previousButton;
    IBOutlet NSButton* _cancelButton;
}
@property (readonly, strong, nonatomic) NSButton* nextButton;
@property (readonly, strong, nonatomic) NSButton* previousButton;
@property (readonly, strong, nonatomic) NSButton* cancelButton;

@end

//
//  ZFBreadCrumbsBar.h
//  FishLamp
//
//  Created by patrickm on 20-11-07.
//  Copyright 2007 GreenTongue Software, LLC.. All rights reserved.
//

#if REFACTOR
#if OSX
#import <Cocoa/Cocoa.h>


/*!
    @header		ZFBreadCrumbsBar
    @abstract   Displays a segmented bar indicating the process step.
    @discussion Performs a similar function as ZFPhaseView.
*/


@interface ZFBreadCrumbsBar : NSView {
@private
	NSArray* _labels;
	IBOutlet NSTabView* _tabView;
}

@property (readwrite, strong, nonatomic) NSArray* labels;

@end
#endif
#endif
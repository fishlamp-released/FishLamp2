//
//  FLZfBreadCrumbsBar.h
//  ZenfolioDownloader
//
//  Created by patrickm on 20-11-07.
//  Copyright 2007 GreenTongue Software, LLC.. All rights reserved.
//

#import <Cocoa/Cocoa.h>


/*!
    @header		FLZfBreadCrumbsBar
    @abstract   Displays a segmented bar indicating the process step.
    @discussion Performs a similar function as FLZfPhaseView.
*/


@interface FLZfBreadCrumbsBar : NSView {
@private
	NSArray* _labels;
	IBOutlet NSTabView* _tabView;
}

@property (readwrite, strong, nonatomic) NSArray* labels;

@end

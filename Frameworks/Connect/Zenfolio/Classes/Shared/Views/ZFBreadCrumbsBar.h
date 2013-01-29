//
//  ZFBreadCrumbsBar.h
//  ZenfolioDownloader
//
//  Created by patrickm on 20-11-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

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

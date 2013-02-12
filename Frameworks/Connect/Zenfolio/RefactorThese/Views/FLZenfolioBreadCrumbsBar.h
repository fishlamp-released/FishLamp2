//
//  FLZenfolioBreadCrumbsBar.h
//  ZenfolioDownloader
//
//  Created by patrickm on 20-11-07.
//  Copyright 2007 GreenTongue Software, LLC.. All rights reserved.
//

#import <Cocoa/Cocoa.h>


/*!
    @header		FLZenfolioBreadCrumbsBar
    @abstract   Displays a segmented bar indicating the process step.
    @discussion Performs a similar function as FLZenfolioPhaseView.
*/


@interface FLZenfolioBreadCrumbsBar : NSView {
@private
	NSArray* _labels;
	IBOutlet NSTabView* _tabView;
}

@property (readwrite, strong, nonatomic) NSArray* labels;

@end

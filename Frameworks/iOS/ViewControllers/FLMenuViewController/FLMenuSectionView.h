//
//  FLMenuViewSection.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGradientView.h"
#import "FLMenuHeaderView.h"

@interface FLMenuSectionView : UIView {
@private
    FLMenuSectionHeaderView* _header;
}

- (id) initWithSectionTitle:(NSString*) sectionTitle;

@property (readwrite, retain,nonatomic) NSString* sectionTitle;

@end

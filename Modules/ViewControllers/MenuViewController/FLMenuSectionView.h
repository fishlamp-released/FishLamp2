//
//  FLMenuViewSection.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright 2011 Greentongue Software. All rights reserved.
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

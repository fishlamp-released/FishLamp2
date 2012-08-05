//
//  FLHeirarchicalGridViewCell.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridViewCell.h"

@interface FLHierarchicalGridViewCell : FLGridViewCell {
@private
    BOOL _discloseFromLeft;
}
+ (FLHierarchicalGridViewCell*) hierarchicalGridViewCell:(id) dataObject;
@end

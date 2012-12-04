//
//  FLHeirarchicalGridViewCell.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridCell.h"

@interface FLHierarchicalGridViewCell : FLGridCell {
@private
    BOOL _discloseFromLeft;
}
+ (FLHierarchicalGridViewCell*) hierarchicalGridViewCell:(id) dataObject;
@end

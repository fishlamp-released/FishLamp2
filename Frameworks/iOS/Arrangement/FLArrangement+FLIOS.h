//
//  FLArrangement+FLIOS.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/21/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLArrangement.h"

@interface FLArrangement (FLIOS)
@property (readwrite, copy, nonatomic) FLArrangementWillLayoutBlock onWillArrangeForPhone;
@property (readwrite, copy, nonatomic) FLArrangementWillLayoutBlock onWillArrangeForPad;
@end

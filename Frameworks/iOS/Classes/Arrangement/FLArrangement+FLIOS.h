//
//  FLArrangement+FLIOS.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLArrangement.h"

@interface FLArrangement (FLIOS)
@property (readwrite, copy, nonatomic) FLArrangementWillLayoutBlock onWillArrangeForPhone;
@property (readwrite, copy, nonatomic) FLArrangementWillLayoutBlock onWillArrangeForPad;
@end

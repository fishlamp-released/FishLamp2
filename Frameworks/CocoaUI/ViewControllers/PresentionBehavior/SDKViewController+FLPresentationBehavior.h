//
//  SDKViewController+FLPresentationBehavior.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/17/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCocoa.h"

#import "FLPresentationBehavior.h"

@interface SDKViewController (FLPresentationBehavior) 

@property (readwrite, retain, nonatomic) id<FLPresentationBehavior> presentationBehavior;

+ (id<FLPresentationBehavior>) defaultPresentationBehavior;

@end
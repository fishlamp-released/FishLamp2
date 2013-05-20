//
//  FLGalleryUserDataModel.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLAction.h"
#import "FLGalleryUser.h"

@protocol FLGalleryUserDataModel <NSObject>
- (FLAction*) userLoaderWithUserID:(id) userID; 
@end

@interface FLAction (FLGalleryUserDataModel)
- (id<FLGalleryUser>) userResult;
@end
//
//  FLGalleryUserDataModel.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
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
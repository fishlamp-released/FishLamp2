//
//  GtCachedPhotoInfo.h
//  MyZen
//
//  Created by Mike Fullerton on 10/30/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtCachedPhotoDataBase.h"

@interface GtCachedPhotoData : GtCachedPhotoDataBase {
	GtPhotoData* m_photoData;
}

- (id) initWithUrl:(NSString*) url;

@property (readwrite, assign, nonatomic) GtPhotoData* photoData;

@end

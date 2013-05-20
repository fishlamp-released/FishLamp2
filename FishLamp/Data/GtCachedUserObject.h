//
//  GtCachedUserObject.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/22/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtObject.h"
@class GtSqlQuery;

@interface GtCachedUserObject : GtObject {

}

GtObjectProperty(NSString*, userName, setUserName);

@end

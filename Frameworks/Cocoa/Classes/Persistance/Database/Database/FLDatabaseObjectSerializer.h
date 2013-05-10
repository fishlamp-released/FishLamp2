//
//  FLDatabaseColumnData.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLDatabaseObjectSerializer : NSObject<NSCoding> {
@private
    id _object;
    Class _objectClass;
}
@property (readonly, strong, nonatomic) id object;
@property (readonly, assign, nonatomic) Class objectClass;

+ (id) objectSerializer:(id) object;

@end
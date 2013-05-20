//
//  GtJsonRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtHttpConnection.h"
#import "GtJsonBuilder.h"

@interface GtJsonRequest : GtHttpConnection {
@private
	GtJsonBuilder* m_json;
}

@property (readonly, retain, nonatomic) GtJsonBuilder* json;

@end

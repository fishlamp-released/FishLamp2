//
//  FLSoapDataEncoder.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"

#import "FLDataEncoder.h"
#import "NSString+XML.h"

@interface FLSoapDataEncoder : NSObject<FLDataEncoder, FLDataDecoder> {
@private
	NSNumberFormatter* _numberFormatter;
}

FLSingletonProperty(FLSoapDataEncoder);

@end

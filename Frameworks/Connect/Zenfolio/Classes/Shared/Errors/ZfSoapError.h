//
//  ZFSoapError.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLSoapError.h"

@interface NSError (ZenfolioSoapError)
+ (NSError*) errorWithZenfolioSoapFault:(FLSoapFault11*) fault;
@end

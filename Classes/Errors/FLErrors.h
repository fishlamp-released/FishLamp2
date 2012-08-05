//
//  FLErrors.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"
#import "NSError+FLExtras.h"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.


// TODO: fix these
#define FLFishlampErrorDomain @"FishlampErrorDomain"
#define FLErrorDomain                   @"FLErrorDomain"
#define FLAssertionFailedErrorDomain    @"FLAssertionFailedErrorDomain"
#define FLAssertionFailedErrorCode      1

#define FLErrorEmptyStringErrorCode     -1234
#define FLErrorUnexpectedNilObject      -1235

#define FLErrorInvalidFolder		-6000
#define FLErrorInvalidName			-6001
#define FLErrorNoDataToSave			-6002

#define FLErrorDuplicateItemErrorCode -7000

#define FLErrorUnknownEnumValue     -8000
#define FLErrorConditionFailed  -9876
#define FLErrorTooManyEnumsErrorCode  -8001


//
//  GtErrors.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

// TODO: fix these
#define GtFishlampErrorDomain @"FishlampErrorDomain"
#define GtErrorDomain                   @"GtErrorDomain"
#define GtAssertionFailedErrorDomain    @"GtAssertionFailedErrorDomain"
#define GtAssertionFailedErrorCode      1

#define GtErrorEmptyStringErrorCode     -1234
#define GtErrorUnexpectedNilObject      -1235

#define GtErrorInvalidFolder		-6000
#define GtErrorInvalidName			-6001
#define GtErrorNoDataToSave			-6002

#define GtErrorDuplicateItemErrorCode -7000

#define GtErrorUnknownEnumValue     -8000
#define GtErrorConditionFailed  -9876

typedef void (^GtErrorCallback)(NSError* error);



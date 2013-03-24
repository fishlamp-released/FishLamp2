//
//  FLServiceKeys.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLServiceKeys.h"

NSString* const FLUserLoginKey = @"com.fishlamp.userlogin";

NSString* const FLUserDataPersistantDatabaseKey = @"com.fishlamp.database.object";
NSString* const FLUserDataCacheDatabaseKey = @"com.fishlamp.database.cache";
NSString* const FLUserDataImageCacheKey = @"com.fishlamp.folder.cache";
NSString* const FLUserDataImageCacheFolderKey = @"com.fishlamp.folder.cache.image";

NSString* const FLUserDataImageTempFolderKey = @"com.fishlamp.folder.temp";
NSString* const FLUserDataImageLogFolderKey = @"com.fishlamp.folder.log";
NSString* const FLUserDataImageDocumentsFolderKey = @"com.fishlamp.folder.documents";

NSString* const FLUserDataImageImageFolderKey = @"com.fishlamp.folder.image";
NSString* const FLHttpRequestContextServiceType = @"com.fishlamp.service.http-request-context";

NSString* const FLServiceTypeCache          = @"com.fishlamp.service.cache";
NSString* const FLServiceTypeStorage        = @"com.fishlamp.service.storage";
NSString* const FLServiceTypeNetworkServer  = @"com.fishlamp.service.server";

NSString* const FLServiceRequestTypeCreate  = @"com.fishlamp.service.request.create";
NSString* const FLServiceRequestTypeRead    = @"com.fishlamp.service.request.read";
NSString* const FLServiceRequestTypeUpdate  = @"com.fishlamp.service.request.update";
NSString* const FLServiceRequestTypeDelete  = @"com.fishlamp.service.request.delete";
NSString* const FLServiceRequestTypeFind    = @"com.fishlamp.service.request.find";

NSString* const FLServiceTypeImageCache     = @"com.fishlamp.service.cache.image";

NSString* const FLServiceTypehttpService = @"com.fishlamp.service.http-request";
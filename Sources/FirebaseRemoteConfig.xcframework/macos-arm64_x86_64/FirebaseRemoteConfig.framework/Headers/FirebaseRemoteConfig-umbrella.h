#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FirebaseRemoteConfig.h"
#import "FIRRemoteConfig.h"

FOUNDATION_EXPORT double FirebaseRemoteConfigVersionNumber;
FOUNDATION_EXPORT const unsigned char FirebaseRemoteConfigVersionString[];

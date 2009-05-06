//
//  Logging.h
//  VoiceCommand
//
//  Created by Jay Lieske on 2008.10.02.
//  Copyright 2008 YellowPages.com. All rights reserved.
//

#import <Foundation/NSObjCRuntime.h>

// Some print-debug macros.  These become no-ops in Release builds.

#ifdef DEBUG

#define NSLOG(...) NSLog(__VA_ARGS__)
// Log the function name.
#define NSLOGFUN() NSLog(@"%s", __PRETTY_FUNCTION__)
// Log the function name and arguments.  The format string should describe the arguments.
#define NSLOGARGS(format, ...) NSLog(@"%s (%@)", __PRETTY_FUNCTION__, [NSString stringWithFormat: format, ## __VA_ARGS__])

#else // no DEBUG

#define NSLOG(...)
#define NSLOGFUN()
#define NSLOGARGS(format, ...)

#endif // DEBUG


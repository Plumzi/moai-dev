//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc. 
// All Rights Reserved. 
// http://getmoai.com
//----------------------------------------------------------------//

#import <UIKit/UIKit.h>
#import "PZMoaiAppDelegate.h"

int main (int argc, char* argv[]) {

	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([PZMoaiAppDelegate class]));
    [pool release];

    return retVal;
}
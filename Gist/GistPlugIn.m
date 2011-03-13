//
//  GistPlugIn.m
//  Gist
//
//  Created by Daniel Tull on 11.03.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "GistPlugIn.h"


@implementation GistPlugIn

@synthesize gistID;

+ (NSArray *)plugInKeys {
    return [NSArray arrayWithObject:@"gistID"];
}

- (void)writeHTML:(id<SVPlugInContext>)context {
    [super writeHTML:context];

    // add dependencies
    [context addDependencyForKeyPath:@"gistID" ofObject:self];
    
    if (self.gistID)
    {
        NSString *string = [NSString stringWithFormat:@"http://gist.github.com/%@.js", self.gistID];
        [context writeJavascriptWithSrc:string];
    }
    else
    {
        [context writePlaceholderWithText:@"Enter a Gist ID in the Inspector" options:0];
    }
}

- (void)makeOriginalSize;
{
    // Generally want to fill the space available with out content
    [self setWidth:nil height:nil];
}

- (void)dealloc {
	[gistID release], gistID = nil;
	[super dealloc];
}

@end

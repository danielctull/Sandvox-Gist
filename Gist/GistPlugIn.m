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


- (void)writeHTML:(id<SVPlugInContext>)context {
    [super writeHTML:context];

    // add dependencies
    [context addDependencyForKeyPath:@"gistID" ofObject:self];
    
    NSString *string = [NSString stringWithFormat:@"http://gist.github.com/%@.js", self.gistID];
    
    [context startElement:@"script" attributes:[NSDictionary dictionaryWithObject:string forKey:@"src"]];
    [context endElement];

}

- (void)dealloc {
	[gistID release], gistID = nil;
	[super dealloc];
}

@end

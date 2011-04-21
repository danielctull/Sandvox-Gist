//
//  GistInspector.m
//  Gist
//
//  Created by Abizer Nasir on 21/04/2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "GistInspector.h"


@implementation GistInspector
@synthesize gistIdField;

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    NSLog(@"Controller created");
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end

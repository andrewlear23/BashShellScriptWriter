//
//  ALMainWindow.h
//  BashShellScriptWriter
//
//  Created by Andrew Lear on 05/09/2014.
//  Copyright (c) 2014 Andrew Lear. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ALMainWindow : NSWindow
@property (nonatomic, retain) IBOutlet NSTextView *tbInput;
@property (nonatomic, retain) IBOutlet NSTextView *tbOutput;
@property (nonatomic, retain) IBOutlet NSTextField *tfFilename;

-(IBAction)generate:(id)sender;

@end

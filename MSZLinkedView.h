//
//  MSZLinkedView.h
//  CoreAnimationWizard
//
//  Created by Marcus S. Zarra on 3/1/08.
//  Copyright 2008 Zarra Studios LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CoreAnimation.h>

@interface MSZLinkedView : NSView {
	
	IBOutlet MSZLinkedView *previousView;
	IBOutlet MSZLinkedView *nextView;

	IBOutlet NSButton *nextButton;
	IBOutlet NSButton *previousButton;
}

@property(retain)MSZLinkedView *previousView, *nextView;

@end

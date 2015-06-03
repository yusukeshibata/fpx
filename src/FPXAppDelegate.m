#import "FPXAppDelegate.h"
#import "FPXPlist.h"
#import <CoreGraphics/CGDirectDisplay.h>

@implementation FPXAppDelegate

@synthesize window;
@synthesize webview;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSDictionary *dic = [FPXPlist retrieve];
    NSScreen *screen = [[NSScreen screens] objectAtIndex:0];
    NSRect screenrect = [screen frame];
    [window setFrame:NSMakeRect([[dic objectForKey:@"x"] intValue],
                                screenrect.size.height - [[dic objectForKey:@"y"] intValue] - [[dic objectForKey:@"h"] intValue],
                                [[dic objectForKey:@"w"] intValue],
                                [[dic objectForKey:@"h"] intValue]) display:YES];
    BOOL dontmakeordertop = [[dic objectForKey:@"dontmakeordertop"] boolValue];
    BOOL removeshadow = [[dic objectForKey:@"removeshadow"] boolValue];
    if(dontmakeordertop) {
        [NSMenu setMenuBarVisible:NO];
        [window makeKeyAndOrderFront:nil];
    } else {
        [window setLevel:NSScreenSaverWindowLevel + 1];
        [window orderFront:nil];
    }
    if(removeshadow) {
        [window setHasShadow:NO];
    }
    if([[dic objectForKey:@"hidecursor"] boolValue])
        CGDisplayHideCursor(kCGDirectMainDisplay);
    
    [webview setMainFrameURL:[dic objectForKey:@"url"]];
}

@end

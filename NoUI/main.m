
#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        let app_delegate = [[AppDelegate alloc] init];
        let app = NSApplication.sharedApplication;
        app.delegate = app_delegate;
        [app run];
    }
    
    return 0;
}

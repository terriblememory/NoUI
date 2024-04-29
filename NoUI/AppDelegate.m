
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    NSWindow* _window;
    id<MTLCommandQueue> _commandQueue;
}

- (void)quit:(NSObject*)sender
{
    let app = NSApplication.sharedApplication;
    [app terminate:sender];
}

- (void)applicationWillFinishLaunching:(NSNotification*)notification
{
    let main_menu = [[NSMenu alloc] init];
    let app_menu_item = [[NSMenuItem alloc] init];
    let app_menu = [[NSMenu alloc] initWithTitle:@"NoUI"];
    
    let app_name = NSRunningApplication.currentApplication.localizedName;
    let quit_item_name = [@"Quit " stringByAppendingString:app_name];
    let quit_item = [app_menu addItemWithTitle:quit_item_name action:@selector(quit:) keyEquivalent:@"q"];
    quit_item.keyEquivalentModifierMask = NSEventModifierFlagCommand;

    app_menu_item.submenu = app_menu;
    
    [main_menu addItem:app_menu_item];
    
    let app = NSApplication.sharedApplication;
    app.mainMenu = main_menu;
}

/**
*/
- (void)applicationDidFinishLaunching:(NSNotification*)aNotification
{
    let rect = CGRectMake(100, 100, 640, 480);

    _window =
        [[NSWindow alloc]
            initWithContentRect:rect
            styleMask:NSWindowStyleMaskClosable|NSWindowStyleMaskTitled
            backing:NSBackingStoreBuffered
            defer:NO];
            
    let device = MTLCreateSystemDefaultDevice();
    
    let mtk_view =
        [[MTKView alloc]
            initWithFrame:rect
            device:device];
            
    mtk_view.colorPixelFormat = MTLPixelFormatBGRA8Unorm_sRGB;
    mtk_view.clearColor = MTLClearColorMake(0.1, 0.1, 0.2, 1);
    mtk_view.delegate = self;
    
    _commandQueue = [mtk_view.device newCommandQueue];
    
    _window.contentView = mtk_view;
    _window.title = @"NoUI Window";
    
    [_window makeKeyAndOrderFront:Nil];
    
    [aNotification.object activateIgnoringOtherApps:YES];
}

/**
*/
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)sender
{
    return YES;
}

/**
*/
- (void)drawInMTKView:(MTKView*)view
{
    @autoreleasepool
    {
        let cmd = [_commandQueue commandBuffer];
        let rpd = view.currentRenderPassDescriptor;
        let enc = [cmd renderCommandEncoderWithDescriptor:rpd];
        
        [enc endEncoding];
        [cmd presentDrawable:view.currentDrawable];
        [cmd commit];
    }
}

/**
*/
- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size
{
}

@end

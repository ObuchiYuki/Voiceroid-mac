import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        VCConfigSaver.default.initialize()
        VCApplicationStateSaver.default.initialize()
    }
    func applicationWillTerminate(_ aNotification: Notification) {}
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

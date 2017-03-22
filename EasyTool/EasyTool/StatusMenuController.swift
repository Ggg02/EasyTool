import Cocoa
extension StatusMenuController: CommonTool{}

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    var currentLocation:String = String()
    var pathItem=NSMenuItem()
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    override func awakeFromNib() {
       
        
        statusItem.menu = statusMenu
        statusItem.title = "EasyTool"
        currentLocation = getlocation()
        pathItem.title = currentLocation
        statusMenu.addItem(pathItem)
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    @IBAction func setClicked(sender: NSMenuItem) {
       let path = openFolderDiag()
        if(path.characters.count<2){return}
        currentLocation = path
        setlocation(withValue: currentLocation)
        pathItem.title = currentLocation
        
    
        
    }
}
